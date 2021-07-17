class CreateWorkouts < ActiveRecord::Migration[6.1]
  def change
    create_table :workouts do |t|
      t.string :name
      t.datetime :date
      t.string :type
      t.float :distance
      t.integer :elapsed_time
      t.boolean :public
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
