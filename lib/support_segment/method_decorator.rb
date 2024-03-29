module SupportSegment
  module MethodDecorator

    def before(method, &block)
      decorate(method, :before, block)
    end

    def after(method, &block)
      decorate(method, :after, block)
    end

    def around(method, &block)
      decorate(method, :around, block)
    end

  private
    def decorate(method, callback, block)
      old_method = instance_method(method)

      define_method(method) do |*args|
        if [:before, :around].include? callback
          self.instance_eval &block
        end

        old_method.bind(self).call(*args)
        
        if [:after, :around].include? callback
          self.instance_eval &block
        end
      end
    end
  end
end