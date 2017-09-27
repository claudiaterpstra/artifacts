class AddDifficultyToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :difficulty, :string
  end
end
