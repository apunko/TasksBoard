class CreateAchievingRecords < ActiveRecord::Migration
  def change
    create_table :achieving_records do |t|
      t.references :user, index: true, foreign_key: true
      t.references :achievement, index: true, foreign_key: true
      t.integer :amount, default: 0

      t.timestamps null: false
    end
  end
end
