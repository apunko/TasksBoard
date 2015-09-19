class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, default: "default"
  end
end
