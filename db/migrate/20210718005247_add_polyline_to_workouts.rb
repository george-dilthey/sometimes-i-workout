class AddPolylineToWorkouts < ActiveRecord::Migration[6.1]
  def change
    add_column :workouts, :polyline, :string
  end
end
