class AnswerAttemptsController < ApplicationController
  include TasksHelper
  include AnswerAttemptsHelper
  
  before_action :authenticate_user!, only: [:new, :create]
  after_action :check_next_achievements, only: :create
  
  def index
    @all = AnswerAttempt.all
  end

  def new
    @attempt = AnswerAttempt.new
    @task_id = params[:id]
    respond_to do |format|
      format.js
    end
  end

  def create
    @attempt = AnswerAttempt.new(attempt_params)  
    @attempt.save
    current_user.update_rate(@attempt)
    redirect_to task_path(params[:answer_attempt][:task_id]), notice: @attempt.result.to_s
  end

  private

    def attempt_params
      attempt_params = params.require(:answer_attempt).permit(:value)
      attempt_params[:user_id] = current_user.id
      attempt_params[:task_id] = current_task_id
      attempt_params[:result] = Task.check_answer(attempt_params[:task_id], attempt_params[:value])
      attempt_params
    end

    def check_next_achievements
      attempts = current_user.answer_attempts
      last_attempt = attempts.last
      puts attempts.to_a
      i = 0
      attempts.each do |attempt|
        puts attempt.to_a
        if attempt.result == true
          i += 1 
        end
      end
      if i == 5
        AchievingRecord.find_or_create_by(user_id: current_user.id, achievement_id: 3, amount: 1)
      end
      if i == 10
        AchievingRecord.find_or_create_by(user_id: current_user.id, achievement_id: 7, amount: 1)
      end
      if i == 20
        AchievingRecord.find_or_create_by(user_id: current_user.id, achievement_id: 10, amount: 1)
      end
      if i == 50
        AchievingRecord.find_or_create_by(user_id: current_user.id, achievement_id: 13, amount: 1)
      end
      if i == 100
        AchievingRecord.find_or_create_by(user_id: current_user.id, achievement_id: 16, amount: 1)
      end
      if last_attempt.result == true
        attempts = AnswerAttempt.where(task_id: last_attempt.task_id, result: true)
        attempts.each do |x|
        end
        if attempts.count == 1
          record = AchievingRecord.find_or_create_by(user_id: current_user.id, achievement_id: 2)
          record.amount += 1
          record.save
        end
      end
    end
end
