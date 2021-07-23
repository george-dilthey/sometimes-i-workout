class AddStarredToSegments < ActiveRecord::Migration[6.1]
  def change
    add_column :segments, :starred, :boolean
  end
end
