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

  def self.dayblock
    tasks = all
    tasks_by_hour = Array.new # Holds the hours
    task_excess = Task.new

    # Run the loop to assign each task to its hour
    while tasks.count > 0 do
      hour_budget = 0 # initialize hour minute budget
      list_for_hour = Array.new

      unless task_excess.duration == nil
        list_for_hour << task_excess
        hour_budget += task_excess.duration
        task_excess = Task.new
      end


      ## Run the loop for each task
      tasks.each do |task|


        ## Check if we still have time
        ## available in the hour budget
        if hour_budget < 60


          ## If time is available,
          ## check if current task
          ## exceeds available time left in hour
          if task.duration + hour_budget > 60

            # calculate excess time
            task_leftover_duration = (task.duration + hour_budget - 60).abs #find out how much excess time there is

            # create task_excess task with generic title & time
            task_excess = Task.new(title: "...", duration: task_leftover_duration) #create new task with excess time as its duration. NOT assigned yet

            # trim excess time from origianl task
            task.duration = 60 - hour_budget #update original task's duration to be what is available in the budget so it has the right size in the view. We DO NOT want it saved permanently.

          end

          list_for_hour << task # assign the current task into this hour

          # update our counters
          hour_budget += task.duration
          tasks = tasks.reject {|member| member == task}

        end

        # break each loop once we our time budget is full. IS THIS CORRECT??
        if hour_budget == 60
          break tasks
        end
      end #task loop finished


      # Add each hour to tasks_by_hour array
      tasks_by_hour << list_for_hour
    end

    ## if there are no more tasks we need to add the excess task here
    if tasks.count == 0 && task_excess.duration != nil
      list_for_hour = Array.new
      list_for_hour << task_excess
      tasks_by_hour << list_for_hour
    end

    tasks_by_hour
  end


  def self.dayblock_no_trim
    tasks = all
    tasks_by_hour = Array.new # Holds the hours

    # Run the loop to assign each task to its hour
    while tasks.count > 0 do
      hour_budget = 0 # initialize daily minute budget
      list_for_hour = Array.new

      # Run the loop that checks if a hour still has budget
      tasks.each do |task|
        if hour_budget < 60
          # group tasks into hours
          list_for_hour << task

          # update our counters
          hour_budget += task.duration
          tasks = tasks.reject {|member| member == task}
        end
      end

      # Add each hour to tasks_by_hour array
      tasks_by_hour << list_for_hour

      # logger.debug tasks_by_day.to_yaml
    end

    tasks_by_hour
  end


  def current_hour
    @current_hour = Time.now
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
