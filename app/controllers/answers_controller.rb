class AnswersController < ApplicationController
  
  def index
  end

  def edit
  end

  def new
    @task_id = params[:id]
    @answer = Answer.new
  end

  def show
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
