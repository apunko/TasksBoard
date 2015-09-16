class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :create]
  after_action :set_current_task_id, only: [:show, :edit, :update, :create]
  before_action :create_options_tags, only: [:edit, :new]
  def index
    @tasks = Task.all
  end

  def create
    @task = Task.new(task_params)
    params[:task][:tag_list].each do |tag|
      @task.tag_list.add(tag)
    end
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
      else
        format.html { render :new}
      end
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.' 
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  def new
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create_options_tags
    @tags = [{ name: 'Hong Kong'}, { name: 'Jamaica'}]
    @options = { theme: 'facebook', tokenValue: 'name', allowCustomEntry: true, preventDuplicates: true, minChars: 2 }
  end

  private

    def task_params
      params.require(:task).permit(:title, :description, :level, :user_id, :tag_list)
    end

    def set_current_task_id
      session[:current_task_id] = @task.id
    end

end
