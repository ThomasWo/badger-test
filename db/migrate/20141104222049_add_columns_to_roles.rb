class AddColumnsToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :border_color, :string
    add_column :roles, :name_location, :integer
    add_column :roles, :interests, :boolean
    add_column :roles, :show_handle, :boolean
  end
end
