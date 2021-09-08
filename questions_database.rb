require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton
  
  def initialize
      # @database = SQLite3::Database.new( "questions.db" )
      super('questions.db')
      self.type_translation = true #to ensure data passed is of the same data type. ex: integer should return integer not str
      self.results_as_hash = true
    end
end
