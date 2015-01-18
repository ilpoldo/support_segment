module SupportSegment
  class FormModel

    class NotImplemented < Exception; end
    class NotValid   < Exception; end

    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    # Forms are never themselves persisted
    def persisted?
      false
    end

  end  
end
