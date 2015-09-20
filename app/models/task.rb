class Task < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy 
  has_many :answer_attempts, dependent: :nullify
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  
  acts_as_taggable
  
  validates :title, presence: true
  validates :description, :level, :user_id, presence: true
  validates :title, length: { in: 3..20 }

  paginates_per 10

  def self.check_answer(task_id, value)
    begin
      task = Task.find(task_id)
      true_answers = task.answers
      true_answers.each do |true_answer|
        if true_answer.value == value
          puts "true_answer value = " + true_answer.value
          puts "value"
          return true 
        end
      end
    rescue
      false
    end  
    false 
  end 

  def tag_list_tokens=(tokens)
    self.tag_list = tokens.gsub("'", "")
  end
end
