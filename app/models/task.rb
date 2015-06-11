class Task < ActiveRecord::Base
  acts_as_list

  validates :title, :duration, presence: true

 before_save :round_duration

  # TODO: chunk tasks in 6-hour blocks (by urgency, :duration)
  def self.total_time
    sum(:duration)
  end

  def self.today
    tasks = all # TODO: incomplete tasks only
    tasks_by_day = Array.new # Holds the day (which holds tasks)

    # Run the loop to assign each task to its day
    while tasks.count > 0 do
      budget = 360 # initialize daily minute budget
      list_for_day = Array.new

      # Run the loop that checks if a day still has budget
      tasks.each do |task|
        if budget > 0
          # group tasks into days
          list_for_day << task

          # update our counters
          budget -= task.duration
          tasks = tasks.reject {|member| member == task}
        end
      end

      # Add each day to tasks_by_day array
      tasks_by_day << list_for_day

      # logger.debug tasks_by_day.to_yaml
    end

    tasks_by_day
  end

  def round_duration
    if self.duration <= 15
      self.duration = 15
    elsif self.duration <= 30
      self.duration = 30
    elsif self.duration <= 45
      self.duration = 45
    elsif self.duration <= 60
      self.duration = 60
   else
      self.duration = 75
    end
  end
end
