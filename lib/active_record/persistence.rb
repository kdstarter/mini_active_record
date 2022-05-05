module ActiveRecord
  module Persistence
    module ClassMethods
      def find_or_create_by(attributes, options = {})
        find_by(attributes) || create(attributes.merge(options))
      end

      def find_or_create_by!(attributes, options = {})
        find_by(attributes) || create!(attributes.merge(options))
      end

      def create(attributes = {})
        _create(attributes)
      end

      def create!(attributes = {})
        _create(attributes, true)
      end

      private
      def _create(attributes, raise_error = false)
        model = new(attributes)

        sql_attrs = attributes.keys.collect {|key| "\'#{key}\'"}.join(',')
        sql_values = attributes.values.collect {|key| "\'#{key}\'"}.join(',')
        sql = "INSERT INTO #{self.to_s.underscore.pluralize} (#{sql_attrs}) VALUES (#{sql_values})"
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
