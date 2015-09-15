module TasksHelper
  def my_task?(task, user)
    begin
      user.tasks.find(task.id)
    rescue 
      false
    end
  end
end
