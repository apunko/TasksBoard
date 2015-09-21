class AnswersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @answer = Answer.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @answer = Answer.find(params[:id])
    @task = Task.find(@answer.task_id)
    if @answer.update(value: params[:answer][:value])
      redirect_to @task, notice: 'Answer was successfully updated.' 
    else
      redirect_to @task, notice: 'Answer was not updated.'
    end
  end

  def new
    @task_id = params[:id]
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)
    @task = Task.find(params[:answer][:task_id])
    respond_to do |format|
      if @answer.save
        format.html { redirect_to task_url(params[:answer][:task_id]), notice: 'Thanks for adding answer!' } 
        format.js 
      else
        format.html {render :new}
      end
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    task_id = @answer.task.id
    @answer.destroy
    redirect_to task_url(task_id), notice: 'Answer was successfully destroyed.'
  end

  private
  def answer_params
    params.require(:answer).permit(:value, :task_id)
  end

end
