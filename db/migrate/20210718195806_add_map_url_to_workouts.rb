class AddMapUrlToWorkouts < ActiveRecord::Migration[6.1]
  def change
    add_column :workouts, :map, :string
  end
end
