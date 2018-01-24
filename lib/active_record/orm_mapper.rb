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
      connection = _init_connection(opts)
      _init_column_names

      define_method 'attribute_names' do
        self.class.attribute_names
      end

      define_method 'attributes' do
        instance_values.select { |key| key.in?(attribute_names) }
      end

      define_method 'empty?' do
        attributes.blank?
      end
      connection
    end

    def connection
      class_variable_get :@@connection
    end

    def attribute_names
      class_variable_get :@@column_names
    end

    def all
      models = []
      sql_query = "SELECT * FROM #{self.to_s.underscore.pluralize}"
      puts "Debug SQL select_all: #{sql_query}"
      rows = connection.execute(sql_query)
      
      rows.each do |row|
        tmp_model = self.new
        row.each_with_index do |attr_val, index|
          func_name = "#{attribute_names[index]}="
          tmp_model.send(func_name, attr_val) if tmp_model.respond_to? func_name
        end
        models.push tmp_model
      end
      models
    end

    private
    def _init_connection(opts)
      # self.superclass --> ActiveRecord::Base
      if self.superclass.class_variables.include?(:@@connection)
        connection = self.superclass.class_variable_get :@@connection
        puts "Debug connection: #{connection.inspect}"
      else
        connection = self.superclass.class_variable_set(:@@connection, ::SQLite3::Database.new(opts[:database]))
        puts "Debug new connection: #{connection.inspect}"
      end
      connection
    end

    def _init_column_names
      # set column_names
      sql_query = "PRAGMA table_info(#{self.to_s.underscore.pluralize})"
      puts "Debug SQL table_info: #{sql_query}"
      column_names = connection.execute(sql_query).map { |array| array[1] }
      class_variable_set(:@@column_names, column_names)
    end
  end
end
