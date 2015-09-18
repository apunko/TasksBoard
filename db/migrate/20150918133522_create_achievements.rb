class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.string :image_url
      t.string :title
      t.string :description

      t.timestamps null: false
    end
  end
end
