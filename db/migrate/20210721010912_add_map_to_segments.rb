class AddMapToSegments < ActiveRecord::Migration[6.1]
  def change
    add_column :segments, :map, :string
  end
end
