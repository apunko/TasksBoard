class CreateAnswerAttempts < ActiveRecord::Migration
  def change
    create_table :answer_attempts do |t|
      t.string :value
      t.boolean :result
      t.references :task, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
