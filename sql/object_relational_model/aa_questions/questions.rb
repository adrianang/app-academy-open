require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User
  attr_accessor :id, :fname, :lname

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM users")
    data.select { |datum| datum["id"] == id }.map { |datum| User.new(datum) }.first
  end

  def initialize(options)
    @id = options["id"]
    @fname = options["fname"]
    @lname = options["lname"]
  end
end

class Question
  attr_accessor :id, :title, :body, :author_id

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    data.select { |datum| datum["id"] == id }.map { |datum| Question.new(datum) }.first
  end

  def initialize(options)
    @id = options["id"]
    @title = options["title"]
    @body = options["body"]
    @author_id = options["author_id"]
  end
end

class QuestionFollow
  attr_accessor :id, :user_id, :question_id

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
    data.select { |datum| datum["id"] == id }.map { |datum| QuestionFollow.new(datum) }.first
  end

  def initialize(options)
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
  end
end

class Reply
  attr_accessor :id, :body, :question_id, :parent_reply_id, :user_id

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    data.select { |datum| datum["id"] == id }.map { |datum| Reply.new(datum) }.first
  end

  def initialize(options)
    @id = options["id"]
    @body = options["body"]
    @question_id = options["question_id"]
    @parent_reply_id = options["parent_reply_id"]
    @user_id = options["user_id"]
  end
end

class QuestionLike
  attr_accessor :id, :user_id, :question_id

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
    data.select { |datum| datum["id"] == id }.map { |datum| QuestionLike.new(datum) }.first
  end

  def initialize(options)
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
  end
end