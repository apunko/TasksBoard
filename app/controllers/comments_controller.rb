class CommentsController < ApplicationController
  include TasksHelper

  def create
    comment = Comment.new(comment_params)
    @task = Task.find(current_task_id)
    respond_to do |format|
      if comment.save
        format.html { redirect_to @task }
      else
        format.html { redirect_to @task, notice: "Can't add comment" }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @task = Task.find(current_task_id)
    redirect_to @task
  end

  private

    def comment_params
      params_hash = params.require(:comment).permit(:message)
      params_hash[:task_id] = current_task_id
      params_hash[:user_id] = current_user.id
      params_hash
    end
end
