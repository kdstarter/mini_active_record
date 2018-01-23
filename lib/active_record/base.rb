require 'sqlite3'

class BasicObject
  def blank?
    nil? ? true : empty?
  end

  def present?
    !blank?
  end
end

module ActiveRecord

  class Base
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
          puts "Error: #{attribute} must_present"
        elsif block_given? && !validation.call(value)
          puts "Error: #{attribute} invaild_attribute"
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

    def establish_connection(opts = {})
      define_method 'connection' do
        connection = instance_variable_get "@connection"
        connection || instance_variable_set("@connection", ::SQLite3::Database.new(opts[:database]))
      end
    end
  end
end
