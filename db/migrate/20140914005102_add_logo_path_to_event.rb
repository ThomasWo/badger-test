class AddLogoPathToEvent < ActiveRecord::Migration
  def change
    add_column :events, :logo_path, :string
  end
end
