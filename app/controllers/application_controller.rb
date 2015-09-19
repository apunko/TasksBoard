class ApplicationController < ActionController::Base
  include TasksHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token, :only => [:search]

  def home
  end

  def download_image
    Achievement.generate_image_of_achievements(current_user)
    send_file("#{Rails.root}/app/assets/images/output.jpg",
    filename: "your_custom_file_name.jpg",
    type: "image/jpeg")
  end

  def search
    @query = params[:q]
    comments = Comment.search @query
    tags = Tag.search @query
    @tasks = Task.search @query
    
    tags.each do |tag|
      task_id = tag.task_id
      task = Task.find(task_id)
      if task
        @tasks << task
      end 
    end

    comments.each do |comment|
      task_id = comment.task_id
      task = Task.find(task_id)
      if task
        @tasks << task
      end 
    end

  end
end
