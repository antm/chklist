class Task < ActiveRecord::Base

  validates :title, :duration, presence: true 
end
