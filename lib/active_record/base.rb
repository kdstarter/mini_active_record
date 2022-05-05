require 'active_support/inflector'
require 'active_support/core_ext/object'
require './lib/active_record/active_record_error.rb'
require './lib/active_record/orm_mapper.rb'
# autoload(:OrmMapper, './lib/active_record/orm_mapper.rb')

module ActiveRecord
  class Base
    include OrmMapper

    class << self
      def inherited(subclass)
        puts "\nDebug model: #{subclass} inherited #{self}"
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
        instance_variable_set("@#{attribute}", value)
        ActiveRecordError.new(attribute: attribute, key: :must_present) if opts[:presence] == true && value.blank?
        ActiveRecordError.new(attribute: attribute, key: :invaild_attribute) if block_given? && !validation.call(value)
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
