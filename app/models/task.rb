class Task < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy 
  has_many :answer_attempts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  acts_as_taggable

  validates :title, :description, :level, :user_id, presence: true
  validates :title, length: { in: 3..20 }

  def self.check_answer(task_id, value)
    begin
      @task = Task.find(task_id)
      @true_answers = @task.answers
      @true_answers.each do |true_answer|
        return true if true_answer.value == value
      end
    rescue
      false
    end  
    false 
  end 

  def tag_list_tokens=(tokens)
    self.tag_list = tokens.gsub("'", "")
  end

  def average_rating(id)
    ratings = Rating.where(task_id: id)
    @result = 0;
    puts "1"
    if ratings
      puts "2"
      sum = 0
      ratings.each do |rate|
        sum += rate.score
      end
      if ratings.length > 0
        @result = (sum / ratings.length).to_i
      end
    end
    @result
  end

end
