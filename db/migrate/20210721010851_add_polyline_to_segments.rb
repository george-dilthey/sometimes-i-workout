class AddPolylineToSegments < ActiveRecord::Migration[6.1]
  def change
    add_column :segments, :polyline, :string
  end
end
