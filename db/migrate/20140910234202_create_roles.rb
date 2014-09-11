class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :level
      t.string :display
      t.references :event, index: true

      t.timestamps
    end
  end
end
