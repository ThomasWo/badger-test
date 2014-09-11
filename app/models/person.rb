require 'csv'

class Person < ActiveRecord::Base
  belongs_to :role

  def self.parse(csv)
    CSV.foreach(csv.path, headers: true) do |row|
      Person.find_or_create_by(
        first_name: row['first-name'],
        last_name: row['last-name'],
        email: row['email']
      )
    end
  end
end
