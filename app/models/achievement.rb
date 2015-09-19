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
      image.resize "35x35"
    end
    image
  end

  def self.handle_image(image, record)
    handle_image = image
    if record.amount > 1
      handle_image = Achievement.draw_text(image, record.amount)
    end
    handle_image.resize "35x35"
    handle_image
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

end
