module ActiveRecord
  module Persistence
    module ClassMethods 
      def create(attributes = nil)
        model, _ = _create(attributes)
        model
      end

      def create!(attributes = nil)
        model, error = _create(attributes)
        raise error if error.present?
      end

      private
      def _create(attributes)
        model = new(attributes)

        sql_attrs = attributes.keys.collect {|key| "\'#{key}\'"}.join(',')
        sql_values = attributes.values.collect {|key| "\'#{key}\'"}.join(',')
        sql = "INSERT INTO users (#{sql_attrs}) VALUES (#{sql_values})"
        puts "Debug SQL: #{sql}"

        begin
          rows = connection.execute(sql)
          [model, '']
        rescue Exception => e
          puts "Error SQL: #{e.inspect}"
          [new, e.inspect]
        end
      end
    end
  end
end