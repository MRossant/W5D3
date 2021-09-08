require 'sqlite3'
require 'singleton'

SQLite3::Database.new( "questions.db" ) do |db|
  db.execute( "select * from users" ) do |row|
    p row
  end
end


class QuestionsDatabase < SQLite3::Database
    include Singleton
    
    def initialize
    super('users.db')
    self.type_translation = true #to ensure data passed is of the same data type. ex: integer should return integer not str
    self.results_as_hash = true
  end
end
