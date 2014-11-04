class AddFieldsToPeople < ActiveRecord::Migration
  def change
    add_column :people, :custom_handle, :string
    add_column :people, :shirt_size, :string
    add_column :people, :diet_restrictions, :text
    add_column :people, :event_id, :integer
  end
end
