class Task < ActiveRecord::Base

  validates :title, :starttime, presence: true 
end
