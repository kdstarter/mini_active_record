module ActiveRecord
  module OrmQuery
    module ClassMethods
      def find_by(query)
        _query_model(query: _to_filter_id(query), raise_error: false)
      end

      def find(query)
        _query_model(query: _to_filter_id(query), raise_error: true)
      end

      def first
        _query_model(limit: 'LIMIT 1')
      end

      def all
        _query_models
      end

      def where(query)
        _query_models(query: query)
      end

      private
      def _to_filter_id(query)
        if query.is_a?(Integer)
          "id=#{query}"
        elsif query.is_a?(String)
          "id=\"#{query}\""
        else
          query
        end
      end

      def _query_model(opts = {})
        model = nil
        sql = _to_sql_filter(opts)
        rows = connection.execute(sql)

        if rows.present?
          row = rows[0]
          model = self.new
          row.each_with_index do |attr_val, index|
            func_name = "#{attribute_names[index]}="
            model.send(func_name, attr_val) if model.respond_to? func_name
          end
        end
        raise "Error model_not_found by `#{sql}`" if opts[:raise_error] && model.blank?
        model
      end

      def _query_models(opts = {})
        models = []
        sql = _to_sql_filter(opts)
        rows = connection.execute(sql)
        
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

      def _to_sql_filter(opts = {})
        query = opts[:query]
        limit = opts[:limit]
        sql = "SELECT * FROM #{self.to_s.underscore.pluralize}"
        if query.blank?

        elsif query.is_a? Hash
          sql_conditions = query.map{|k,v| "#{k}=#{v}"}.join(' AND ')
          sql = "#{sql} WHERE #{sql_conditions}"
        elsif query.is_a? String
          sql = "#{sql} WHERE #{query}"
        else
          puts "Error SQL: #{query}"
        end

        sql = "#{sql} #{limit}" if limit.present?
        puts "Debug SQL: `#{sql}`"
        sql
      end
    end
  end
end
