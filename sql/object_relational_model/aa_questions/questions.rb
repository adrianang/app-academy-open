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

  def self.find_by_name(fname, lname)
    data = QuestionsDatabase.instance.execute("SELECT * FROM users")
    data.select { |datum| (datum["fname"] == fname) && (datum["lname"] == lname) }.map { |datum| User.new(datum) }
  end

  def initialize(options)
    @id = options["id"]
    @fname = options["fname"]
    @lname = options["lname"]
  end

  def authored_questions
    Question.find_by_author_id(self.id)
  end

  def authored_replies
    Reply.find_by_user_id(self.id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(self.id)
  end
end

class Question
  attr_accessor :id, :title, :body, :author_id

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    data.select { |datum| datum["id"] == id }.map { |datum| Question.new(datum) }.first
  end

  def self.find_by_author_id(author_id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    data.select { |datum| datum["author_id"] == author_id }.map { |datum| Question.new(datum) }
  end

  def initialize(options)
    @id = options["id"]
    @title = options["title"]
    @body = options["body"]
    @author_id = options["author_id"]
  end

  def author
    User.find_by_id(self.author_id)
  end

  def replies
    Reply.find_by_question_id(self.id)
  end

  def followers
    QuestionFollow.followers_for_question_id(self.id)
  end
end

class QuestionFollow
  attr_accessor :id, :user_id, :question_id

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
    data.select { |datum| datum["id"] == id }.map { |datum| QuestionFollow.new(datum) }.first
  end

  def self.followers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        users
      JOIN
        question_follows
        ON question_follows.user_id = users.id
      WHERE
        question_follows.question_id = #{ question_id }
    SQL
    data.map { |datum| User.new(datum) }
  end

  def self.followed_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        questions
      JOIN
        question_follows
        ON question_follows.question_id = questions.id
      WHERE
        question_follows.user_id = #{ user_id }
    SQL
    data.map { |datum| Question.new(datum) }
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

  def self.find_by_user_id(user_id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    data.select { |datum| datum["user_id"] == user_id }.map { |datum| Reply.new(datum) }
  end

  def self.find_by_question_id(question_id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    data.select { |datum| datum["question_id"] == question_id }.map { |datum| Reply.new(datum) }
  end

  def initialize(options)
    @id = options["id"]
    @body = options["body"]
    @question_id = options["question_id"]
    @parent_reply_id = options["parent_reply_id"]
    @user_id = options["user_id"]
  end

  def author
    User.find_by_id(self.user_id)
  end

  def question
    Question.find_by_id(self.question_id)
  end

  def parent_reply
    Reply.find_by_id(self.parent_reply_id)
  end

  def child_replies
    all_questions_replies = Reply.find_by_question_id(self.question_id)
    all_questions_replies.select { |reply| reply.parent_reply_id == self.id }
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