class Event < ActiveRecord::Base
  has_many :people, :through => :roles, :dependent => :destroy
  has_many :roles, :dependent => :destroy

  mount_uploader :logo, ImageUploader, mount_on: :logo_path

  validates :name, :start_date, :end_date, presence: true
end
