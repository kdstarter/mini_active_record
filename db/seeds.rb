require 'sqlite3'

# Open a database
db = SQLite3::Database.new 'my_active_record.db'

# Create a table
sql_create_table = <<-SQL
  CREATE TABLE IF NOT EXISTS users (
    name varchar(20),
    email varchar(30)
  );
SQL
rows = db.execute sql_create_table
puts "SQL result: #{rows == []}, #{sql_create_table}"

rows = db.execute 'PRAGMA table_info(users);'
puts "column_names: #{rows}"
