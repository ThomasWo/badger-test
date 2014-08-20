class Event < ActiveRecord::Base
  has_many :people, :dependent => :destroy
end
