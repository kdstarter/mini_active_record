require 'sqlite3'

module ActiveRecord
  module OrmMapper
    class << self
      def included(base)
        puts "Debug: #{base} included #{self}"
        base.extend ClassMethods
      end
    end
  end

  module ClassMethods
    def establish_connection(opts = {})
      begin
        # self.superclass --> ActiveRecord::Base
        connection = self.superclass.class_variable_get "@@connection"
      rescue NameError => e
        puts "Debug no connection: #{e.inspect}"
        connection = self.superclass.class_variable_set("@@connection", ::SQLite3::Database.new(opts[:database]))
      end
      puts "Debug connection: #{connection.inspect}"

      # set column_names
      sql_query = "PRAGMA table_info(#{self.to_s.underscore.pluralize})"
      puts "Debug SQL table_info: #{sql_query}"
      column_names = connection.execute(sql_query).map { |array| array[1] }
      class_variable_set("@@column_names", column_names)

      define_method 'attribute_names' do
        self.class.class_variable_get "@@column_names"
      end

      define_method 'empty?' do
        puts "Warn: fix me #{self.class}.empty?"
        false
      end

      connection
    end
  end
end
