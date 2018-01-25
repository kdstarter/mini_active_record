require 'sqlite3'

# Open a database
db = SQLite3::Database.new 'mini_active_record.db'

# Create a table
sql_create_table = <<-SQL
  CREATE TABLE IF NOT EXISTS users (
    id integer PRIMARY KEY autoincrement,
    name varchar(20),
    email varchar(30) unique
  );
  CREATE TABLE IF NOT EXISTS posts (
    id integer PRIMARY KEY autoincrement,
    user_id integer,
    title varchar(255),
    content text
  )
SQL
sql_create_table.split(';').each do |sql|
  rows = db.execute sql
  puts "SQL create_table: #{rows == []}, #{sql}"
end

rows = db.execute 'PRAGMA table_info(posts);'
puts "column_names: #{rows}"

sql_insert_rows = <<-SQL
  INSERT INTO users ('name', 'email') VALUES ('Tester', 'test@test.com');
  INSERT INTO posts VALUES (2, 1, 'News', 'Please review the followings...')
SQL
sql_insert_rows.split(';').each do |sql|
  rows = db.execute sql
  puts "SQL insert_row: #{rows == []}, #{sql}"
end
