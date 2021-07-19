class RemovePolylineFromSegments < ActiveRecord::Migration[6.1]
  def change
    remove_column :segments, :polyline, :string
  end
end
