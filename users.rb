require_relative "questions_database"
require "byebug"

class User 
    attr_reader :id
    attr_accessor :fname, :lname
    
    # def initialize(options = {})
    #     @id = options['id']
    #     @fname = options['fname']
    #     @lname = options['lname']
   
    # end
    def initialize(options = {})
        @id, @fname, @lname = options.values_at('id', 'fname', 'lname')
    end

    def self.all 
        data = QuestionsDatabase.instance.execute("SELECT * FROM users") 
        data.map { |datum| User.new(datum)} #generating a row for each user which represents an []
    end

    def self.find_by_id(id)
        user = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            users
        WHERE 
            id = ?
        SQL
        return nil unless user.length > 0 #return nil if we dont have a table i.e arr.empty?
        User.new(user) #returns arr representing user data
    end

    def self.find_by_name(fname, lname)
        user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        SELECT
            *        
        FROM
            users
        WHERE 
            fname = ? AND lname = ?
        SQL
        return nil unless user.length > 0
        User.new(user)
    end


end
