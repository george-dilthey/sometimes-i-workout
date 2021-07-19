class RemoveMapFromSegments < ActiveRecord::Migration[6.1]
  def change
    remove_column :segments, :map, :string
  end
end
