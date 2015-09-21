class RatingsController < ApplicationController
  def create
    @rating = Rating.create(rating_params)
    @task = Task.find(current_task_id)
    respond_to do |format|
      format.js
    end
  end

  private 

  def rating_params
    params_hash = {}
    params_hash[:score] = params[:score]
    params_hash[:user_id] = current_user.id
    params_hash[:task_id] = current_task_id
    params_hash
  end

end
