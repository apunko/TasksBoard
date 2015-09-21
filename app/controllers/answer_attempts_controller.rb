class AnswerAttemptsController < ApplicationController
  include AnswerAttemptsHelper
  
  before_action :authenticate_user!, only: [:new, :create]
  after_action :check_next_achievements, only: :create
  
  def new
    @attempt = AnswerAttempt.new
    @task_id = params[:id]
    respond_to do |format|
      format.js
    end
  end

  def create
    @attempt = AnswerAttempt.new(attempt_params)  
    current_user.update_rate(@attempt)
    @attempt.save
    redirect_to task_path(params[:answer_attempt][:task_id]), notice: "Your answer was " + @attempt.result.to_s
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
    Achievement.check_task_achievements(current_user)
  end
end
