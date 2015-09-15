class Task < ActiveRecord::Base
  belongs_to :user
  has_many :answers 
  has_many :answer_attempts

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
end
