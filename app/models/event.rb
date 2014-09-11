class Event < ActiveRecord::Base
  has_many :people, :through => :roles, :dependent => :destroy
  has_many :roles, :dependent => :destroy
end
