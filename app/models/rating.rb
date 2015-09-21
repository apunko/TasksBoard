class Rating < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  def self.average_rating(task_id)
    ratings = Rating.where(task_id: task_id)
    result = 0.0;
    if ratings
      sum = 0.0
      ratings.each { |rate| sum += rate.score }
      result = (sum / ratings.length).round(1) if ratings.length > 0
    end
    result
  end

end
