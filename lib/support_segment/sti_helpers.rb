#-------------------------------------------------------------------------------
# From: https://gist.github.com/1139595
# This module is meant to be included in the Base class of an STI model 
# hierarchy.
#
# Heavily inspired by a couple key blog posts
#   http://code.alexreisner.com/articles/single-table-inheritance-in-rails.html
#   http://coderrr.wordpress.com/2008/04/22/building-the-right-class-with-sti-in-rails/#comment-1826
# 
#  Thanks to Alex and coderrr!
#-------------------------------------------------------------------------------
module SupportSegment
  module StiHelpers

    def self.included(base)
      base.send :include, InstanceMethods
      base.extend ClassMethods
    end

    module ClassMethods


      def select_options
        descendants.map{ |c| c.to_s }.sort
      end

      def sti_helpers_base
        true
      end

      def sti_association_extensions
        @sti_association_extensions ||= Module.new
      end

      def inherited(child)
        super
        base = sti_base_class


        child.instance_eval do
          def self.sti_helpers_base
            false
          end

          def model_name
            sti_base_class.model_name
          end
        end

        method_name = :"#{child.name.to_s.demodulize.underscore.pluralize}"

        base.define_singleton_method method_name do
          where(inheritance_column.to_sym => child.name)
        end

        sti_association_extensions.send :define_method, method_name do
          relation = where(inheritance_column.to_sym => child.name)
          relation.define_singleton_method :build do |*args, &block|
            result = super(*args, &block)
            proxy_association.add_to_target(result)
          end
          
          relation
        end

      end

      def sti_base_class
        # TODO: use the included hook to set the sti_base_class class?
        if self.sti_helpers_base
          return self
        end
        return superclass.sti_base_class
      end

      def implied_inheritance_class(*inheritance_type_sources)
        if scope_values = self.current_scope.try(:where_values_hash)
          inheritance_type_sources << scope_values
        end

        valid_sources = inheritance_type_sources.select do |source|
          source.is_a? Hash
        end

        inheritance_type = valid_sources.inject(nil) do |type, values|
           type ? type : values.with_indifferent_access[inheritance_column]
        end

        inheritance_type
      end

      # !! with the first conditional clause type logic will only apply to base class
      #     this MAY not be what you'd want, in which case ommit.
      def new(*a, &b)
        if (self == sti_base_class) \
        and (subclass_name = implied_inheritance_class(a.first)) \
        and (subclass = subclass_name.safe_constantize) != self
          raise "wtF hax!!"  unless subclass < self  # klass should be a descendant of us
          return subclass.new(*a, &b)
        end
        super(*a, &b)
      end

    end

    module InstanceMethods
      def sti_base_class
        self.class.sti_base_class
      end
    end

  end

end