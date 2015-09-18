class AnswerAttempt < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  def to_a
    mas = ""
    mas += "user_id: " + self.user_id.to_s + " task_id:" +  self.task_id.to_s + " " + self.result.to_s
    mas
  end
end
