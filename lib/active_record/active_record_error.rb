module ActiveRecord
  class ActiveRecordError < StandardError
    def initialize(opts = {})
      attribute = opts[:attribute] || :base
      raise_error = opts[:raise_error] || false
      error_msg = "ARError: #{attribute} #{opts[:key]}, #{opts[:detail]&.inspect}"
      puts error_msg
      raise error_msg if raise_error
    end
  end
end
