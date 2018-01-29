module ActiveRecord
  module Persistence
    module ClassMethods 
      def create(attributes = nil)
        _create(attributes)
      end

      def create!(attributes = nil)
        _create(attributes, true)
      end

      private
      def _create(attributes, raise_error = false)
        model = new(attributes)

        sql_attrs = attributes.keys.collect {|key| "\'#{key}\'"}.join(',')
        sql_values = attributes.values.collect {|key| "\'#{key}\'"}.join(',')
        sql = "INSERT INTO users (#{sql_attrs}) VALUES (#{sql_values})"
        puts "Debug SQL: `#{sql}`"

        begin
          rows = connection.execute(sql)
          model
        rescue Exception => e
          ActiveRecordError.new(key: :failed_create, detail: e.inspect, raise_error: raise_error)
          new
        end
      end
    end
  end
end
