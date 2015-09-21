class AddStyleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :style, :integer, default: 0
  end
end
