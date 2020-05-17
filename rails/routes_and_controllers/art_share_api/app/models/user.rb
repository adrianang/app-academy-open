class User < ActiveRecord
  validates :username, presence: true, uniqueness: true
end