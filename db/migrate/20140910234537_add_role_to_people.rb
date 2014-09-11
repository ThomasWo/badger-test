class AddRoleToPerson < ActiveRecord::Migration
  def change
    add_reference :people, :role, index: true
  end
end
