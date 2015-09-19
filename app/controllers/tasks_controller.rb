class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :create]
  after_action :set_current_task_id, only: [:show, :edit, :update, :create]
  before_action :create_options_tags, only: [:edit, :new]
  after_action :check_next_achievements, only: :create
  
  def index
    @tasks = Task.all
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
      redirect_to new_task_url, notice: "Can't create task. Check out params."
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
    average_rating = Rating.average_rating(params[:id])
    @rating = Rating.where(task_id: @task.id, user_id: current_user.id).first
    if !@rating  
      @rating = Rating.create(task_id: @task.id, user_id: current_user.id, score: average_rating) 
    end
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
      params_hash = params.require(:task).permit(:title, :description, :level, :tag_list)
      params_hash[:user_id] = current_user.id
      params_hash
    end

    def set_current_task_id
      session[:current_task_id] = @task.id
    end

    def check_next_achievements
      if current_user.tasks.count == 5
        AchievingRecord.find_or_create_by(user_id: current_user.id, achievement_id: 5, amount: 1)
      end
      if current_user.tasks.count == 10
        AchievingRecord.find_or_create_by(user_id: current_user.id, achievement_id: 9, amount: 1)
      end
      if current_user.tasks.count == 20
        AchievingRecord.find_or_create_by(user_id: current_user.id, achievement_id: 12, amount: 1)
      end
      if current_user.tasks.count == 50
        AchievingRecord.find_or_create_by(user_id: current_user.id, achievement_id: 15, amount: 1)
      end
      if current_user.tasks.count == 100
        AchievingRecord.find_or_create_by(user_id: current_user.id, achievement_id: 18, amount: 1)
      end
    end
end
