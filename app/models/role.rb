class Role < ActiveRecord::Base
  belongs_to :event
  has_many :people

  validates :level, uniqueness: { case_sensitive: false, message: 'Level should be unique.' }
end
