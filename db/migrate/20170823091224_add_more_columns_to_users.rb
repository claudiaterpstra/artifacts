class AddMoreColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :facebook, :string
    add_column :users, :twitter, :string
    add_column :users, :instagram, :string
    add_column :users, :dribbble, :string
    add_column :users, :github, :string
  end
end
