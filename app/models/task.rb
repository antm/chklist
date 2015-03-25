class Task < ActiveRecord::Base

  validates :title, :duration, presence: true 

  # TODO: chunk tasks in 6-hour blocks (by urgency, duration)

  def self.today
    tasks = all # TODO: incomplete tasks only
    tasks_by_day = Array.new

    while tasks.count > 0 do
      budget = 360 # initialize daily minute budget
      list_for_day = Array.new
      # logger.debug "Tasks: #{tasks.count}, Budget: #{budget}, List: #{list_for_day.count}"
      tasks.each do |task|
        if budget > 0 
          # group tasks into days
            list_for_day << task.title

            # update our counters
            budget -= task.duration
            tasks = tasks.reject {|member| member == task}

            # logger.debug "Tasks: #{tasks.count}, Budget: #{budget}, List: #{list_for_day.count}"
          end
      end

      tasks_by_day << list_for_day
      # logger.debug tasks_by_day.to_yaml

    end
    tasks_by_day
  end



end
