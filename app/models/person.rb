require 'csv'

class Person < ActiveRecord::Base
  belongs_to :role
  belongs_to :event

  def self.parse(csv, event)
    CSV.foreach(csv.path, headers: true) do |row|
      event.people.build(
        first_name: row['first-name'],
        last_name: row['last-name'],
        email: row['email'],
        custom_handle: self.sanitize_handle(row['handle']),
        shirt_size: row['shirt-size'],
        diet_restrictions: row['diet'],
        role_id: Role.find_by_level(row['role']).id
      )
      event.save
    end
  end

  private

  def self.sanitize_handle(handle)
    return unless handle

    '@' + handle.match(/[a-zA-Z0-9_]*$/)[0]
  end
end
