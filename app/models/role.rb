class Role < ActiveRecord::Base
  belongs_to :event
  has_many :people

  validates :level, :display, presence: true
  validates :level, uniqueness: { case_sensitive: false, scope: :event_id, message: 'Level should be unique.' }
end
