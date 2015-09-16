class AnswerAttemptsController < ApplicationController
  include TasksHelper
  include AnswerAttemptsHelper
  
  before_action :authenticate_user!, only: [:new, :create]

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
    update_statistics(@attempt)
    @attempt.save
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
end
