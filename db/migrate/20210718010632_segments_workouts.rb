class SegmentsWorkouts < ActiveRecord::Migration[6.1]
  def change
    create_table :segments_workouts, id: false do |t|
      t.belongs_to :segment
      t.belongs_to :workout
    end
  end
end
