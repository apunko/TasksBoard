module AchievementsAdding
  
  def check_task_achievements(user)
    attempts = user.answer_attempts
    last_attempt = attempts.last
    i = 0
    attempts.each { |attempt| i += 1 if attempt.result }
    case
    when i == 5
      AchievingRecord.find_or_create_by(user_id: user.id, achievement_id: 3, amount: 1)
    when i == 10
      AchievingRecord.find_or_create_by(user_id: user.id, achievement_id: 7, amount: 1)
    when i == 20
      AchievingRecord.find_or_create_by(user_id: user.id, achievement_id: 10, amount: 1)
    when i == 50
      AchievingRecord.find_or_create_by(user_id: user.id, achievement_id: 13, amount: 1)
    when i == 100
      AchievingRecord.find_or_create_by(user_id: user.id, achievement_id: 16, amount: 1)
    end
    if last_attempt.result
      attempts = AnswerAttempt.where(task_id: last_attempt.task_id, result: true)
      if attempts.count == 1
        record = AchievingRecord.find_or_create_by(user_id: user.id, achievement_id: 2)
        record.amount += 1
        record.save
      end
    end
  end

  def check_new_comments_achievements(user)
    comments_count = user.comments.count
    case
    when comments_count == 5
      AchievingRecord.find_or_create_by(user_id: user.id, achievement_id: 4, amount: 1)
    when comments_count == 10
      AchievingRecord.find_or_create_by(user_id: user.id, achievement_id: 8, amount: 1)
    when comments_count == 20
      AchievingRecord.find_or_create_by(user_id: user.id, achievement_id: 11, amount: 1)
    when comments_count == 50
      AchievingRecord.find_or_create_by(user_id: user.id, achievement_id: 14, amount: 1)
    when comments_count == 100
      AchievingRecord.find_or_create_by(user_id: user.id, achievement_id: 17, amount: 1)
    end
  end

  def check_task_add_achievements(user)
    tasks_count = user.tasks.count
    case
    when tasks_count == 5
      AchievingRecord.find_or_create_by(user_id: user.id, achievement_id: 5, amount: 1)
    when tasks_count == 10
      AchievingRecord.find_or_create_by(user_id: user.id, achievement_id: 9, amount: 1)
    when tasks_count == 20
      AchievingRecord.find_or_create_by(user_id: user.id, achievement_id: 12, amount: 1)
    when tasks_count == 50
      AchievingRecord.find_or_create_by(user_id: user.id, achievement_id: 15, amount: 1)
    when tasks_count == 100
      AchievingRecord.find_or_create_by(user_id: user.id, achievement_id: 18, amount: 1)
    end
  end

  def add_welcom_achievement(id)
    AchievingRecord.create(user_id: id, achievement_id: 1, amount: 1)
  end
end