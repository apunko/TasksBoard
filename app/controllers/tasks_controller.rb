class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
      else
        format.html { render :new}
      end
    end
  end

  def update
  end

  def destroy
  end

  def new
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
  end

  private

    def task_params
      params.require(:task).permit(:title, :description, :level, :user_id)
    end
end
