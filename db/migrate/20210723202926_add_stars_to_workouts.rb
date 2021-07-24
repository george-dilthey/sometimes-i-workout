class AddStarsToWorkouts < ActiveRecord::Migration[6.1]
  def change
    add_column :workouts, :stars, :integer, :default => 0
  end
end
