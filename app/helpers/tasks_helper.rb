module TasksHelper
  def task_my?(task, user)
    begin
      user.tasks.find(task.id)
    rescue 
      false
    end
  end
end
