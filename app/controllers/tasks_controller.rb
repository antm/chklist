class TasksController < ApplicationController
  before_action :get_task, only: [:edit, :update, :destroy]

  def get_task #where should this go on the page, before or after the edit,update, etc?
    @task = Task.find params[:id]
  end

  def index
    @tasks = Task.order('position').today
    @total_time = Task.total_time
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new params_task

    if @task.save
      redirect_to tasks_url
    else
      render 'new'
    end
  end

  def show
    @task = Task.find params[:id]
  end

  def edit
  end

  def update
    if @task.update params_task
      redirect_to tasks_url
    else
      render 'edit'
    end
  end

  def destroy
    if @task.destroy
      redirect_to tasks_url, notice: "#{@task.title} destroyed (add undo link here)"
    else
      redirect_to @task, alert: 'Woops'
    end
  end

  def sort
    params[:task].each_with_index do |id, index|
      Task.where(id: id).update_all({position: index+1})
    end
    render nothing: true
  end

  def dayblock
    @tasks = Task.order('position').dayblock
    @total_time = Task.total_time
    current_time
  end

  def current_time
    t = Time.now
    t += 1.hours
    @hour_block = t.strftime("%l %p").strip!
  end

  private

    def params_task
      params.require(:task).permit(:duration, :title, :important, :task)
    end

end
