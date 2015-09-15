class Task < ActiveRecord::Base
  belongs_to :user
  has_many :answers 
  has_many :answer_attempts
end
