class Achievement < ActiveRecord::Base
  
  def self.generate_image_of_achievements(user)
    background = MiniMagick::Image.open("#{Rails.root}/app/assets/images/achieves/background.jpg") 
    x = 5
    y = 50
    i = 0
    Achievement.all.each do |achievement|
      i += 1
      background = Achievement.draw_achievement(background, achievement, user, x, y)
      x += 80
      if i == 6
        y += 80
        x = 5
      end
      if i == 12 
        y += 80
        x = 5
      end
    end
    background = draw_stat(background, user)
    background.write "#{Rails.root}/app/assets/images/output.jpg"
  end


  def self.draw_achievement(background, achievement, user_id, x, y)
    image = Achievement.make_image(achievement, user_id)
    result = background.composite(image) do |c|
      c.compose "Over"    # OverCompositeOp
      c.geometry "+#{x}+#{y}" # copy second_image onto first_image from (20, 20)
    end
    result
  end

  def self.make_image(achievement, id)
    image = MiniMagick::Image.open("#{Rails.root}/app/assets/images/"+achievement.image_url)
    record = AchievingRecord.find_by(user_id: id, achievement_id: achievement.id)
    if record  
      image = Achievement.handle_image(image, record)
    else
      image.colorspace "Gray"
      image.resize "75x75"
    end
    image
  end

  def self.handle_image(image, record)
    handle_image = image
    if record.amount > 1
      handle_image = Achievement.draw_text(image, record.amount)
    end
    handle_image.resize "75x75"
    handle_image
  end

  def self.draw_stat(image, user)
    image.combine_options do |c|
      c.pointsize '18'
      c.draw "text 20,20 "+"#{user.name}"
      c.fill 'white'
    end
    image
  end

  def self.draw_text(image, text)
    image.combine_options do |c|
      c.pointsize '18'
      c.draw "text 80,80 A"
      c.fill 'red'
    end
    image
  end

  def self.draw_image(bg, image, x, y)
    result = bg.composite(image) do |c|
      c.compose "Over"
      c.geometry "+#{x}+#{y}"
    end
    result
  end

  def self.check_task_achievements(user)
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

  def self.check_new_comments_achievements(user)
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
end
