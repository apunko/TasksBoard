class TasksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  after_action :set_current_task_id, only: [:show, :edit, :update, :create]
  before_action :create_options_tags, only: [:edit, :new]
  after_action :check_next_achievements, only: :create

  def index
    @tasks = Task.order(:title).page params[:page]
  end

  def create
    @task = Task.new(task_params)
    if params[:task][:tag_list] 
      params[:task][:tag_list].each do |tag|
        @task.tag_list.add(tag)
      end
    end
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.' 
    else
      flash[:error] = @task.errors.messages
      redirect_to new_task_url
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

  private
  def task_params
    params_hash = params.require(:task).permit(:title, :description, :level, :tag_list)
    params_hash[:user_id] = current_user.id
    params_hash
  end

  def set_current_task_id
    session[:current_task_id] = @task.id
  end

  def check_next_achievements
    Achievement.check_task_add_achievements(current_user)
  end

  def create_options_tags
    @tags = ActsAsTaggableOn::Tag.all
    @options = { :theme => 'facebook', :tokenValue => 'name', 
                 :allowCustomEntry => true, :reventDuplicates => true, :minChars => 1 }
  end
end
