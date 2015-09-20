class Rating < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  def self.average_rating(task_id)
    ratings = Rating.where(task_id: task_id)
    result = 0.0;
    if ratings
      sum = 0
      ratings.each do |rate|
        sum += rate.score
      end
      if ratings.length > 0
        result = (sum / ratings.length).round(2)
      end
    end
    result
  end

end
