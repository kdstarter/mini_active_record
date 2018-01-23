module ActiveRecord
  class Base
    class << self
      def inherited(subclass)
        puts "#{subclass} inherited #{self}"
        subclass.extend ClassMethods
      end
    end
  end

  module ClassMethods
    def attr_accessor(*attributes)
      attributes = [attributes] unless attributes.is_a? Array
      attributes.each do |attribute|
        define_method "#{attribute}=" do |value|
          instance_variable_set("@#{attribute}", value)
        end

        define_method attribute do
          instance_variable_get "@#{attribute}"
        end
      end
    end
  end
end
