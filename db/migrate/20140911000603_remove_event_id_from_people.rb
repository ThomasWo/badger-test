class RemoveEventIdFromPeople < ActiveRecord::Migration
  def up
  	remove_index :people, :event_id
  	remove_column :people, :event_id
  end

  def down
  	add_column :people, :event_id, :integer
  	add_index :people, :event_id
  end
end
