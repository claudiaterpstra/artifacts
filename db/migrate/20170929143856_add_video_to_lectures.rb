class AddVideoToLectures < ActiveRecord::Migration[5.0]
  def change
    add_column :lectures, :video, :string
  end
end
