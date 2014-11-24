module SupportSegment
  class ReceiverValidator < ActiveModel::EachValidator

    def validate_each(record, attribute, value)
      if Array.wrap(value).reject {|r| r.marked_for_destruction? || r.valid?(record.validation_context) }.any?
        receiver = record.public_method(attribute).call
        if options[:map_attributes]
          options[:map_attributes].each do |receiver_attribute, command_attribute|
            if errors = receiver.errors.delete(receiver_attribute)
              errors.each do |error|
                record.errors.add(command_attribute, error)
              end
            end
          end
        end
        unless receiver.errors.empty?
          record.errors.add(attribute, :invalid, options.merge(value: value))
        end
      end
    end

  end
end