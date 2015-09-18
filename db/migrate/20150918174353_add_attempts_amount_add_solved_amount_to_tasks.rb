class AddAttemptsAmountAddSolvedAmountToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :attempts_amount, :integer, default: 0
    add_column :tasks, :solved_amount, :integer, default: 0
  end
end
