class Achievement < ActiveRecord::Base
  extend DrawIconModule
  extend AchievementsAdding
  
  def self.generate_image_of_achievements(user)
    generate_image(user)
  end
end
