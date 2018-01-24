require 'active_support/inflector'
require 'active_support/core_ext/object'
require './lib/active_record/orm_mapper.rb'
# autoload(:OrmMapper, './lib/active_record/orm_mapper.rb')

module ActiveRecord
  class Base
    include OrmMapper

    class << self
      def inherited(subclass)
        puts "Debug: #{subclass} inherited #{self}"
        subclass.extend ClassMethods
      end
    end

    def initialize(attributes = {})
      attributes.each do |attribute, value|
        send("#{attribute}=", value)
      end
    end
  end

  module ClassMethods
    def validates(attribute, opts = {}, &validation)
      define_method "#{attribute}=" do |value|
        if opts[:presence] == true && value.blank?
          puts "\nError: #{attribute} must_present"
        elsif block_given? && !validation.call(value)
          puts "\nError: #{attribute} invaild_attribute"
        else
          instance_variable_set("@#{attribute}", value)
        end
      end
    end

    def attr_accessor(*attributes)
      attributes = [attributes] unless attributes.is_a? Array
      attributes.each do |attribute|
        define_method "#{attribute}=" do |value|
          instance_variable_set("@#{attribute}", value)
        end unless instance_methods.include?("#{attribute}=")
        
        define_method attribute do
          instance_variable_get "@#{attribute}"
        end
      end
    end
  end
end
