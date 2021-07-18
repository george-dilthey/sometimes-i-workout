class CreateSegments < ActiveRecord::Migration[6.1]
  def change
    create_table :segments do |t|
      t.string :name
      t.float :distance
      t.string :polyline

      t.timestamps
    end
  end
end
