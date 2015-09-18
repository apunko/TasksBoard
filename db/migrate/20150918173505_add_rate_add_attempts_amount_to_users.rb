class AddRateAddAttemptsAmountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rate, :integer, default: 0
    add_column :users, :attempts_amount, :integer, default: 0
    add_column :users, :solved_amount, :integer, default: 0
    add_column :users, :comments_amount, :integer, default: 0
    add_column :users, :own_tasks_amount, :integer, default: 0
  end
end
