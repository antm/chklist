class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new params_task
    if @task.save
      redirect_to @task
    else
      render 'new'
    end
  end

  def show
    @task = Task.find params[:id]
  end

  def edit
    @task = Task.find params[:id]
  end

  def update
    @task = Task.find params[:id]
    if @task.update params_task
      redirect_to tasks_url
    else
      render 'edit'
    end
  end

  def destroy
    @task = Task.find params[:id]
    if @task.destroy 
      redirect_to tasks_url, notice: "#{@task.title} destroyed (add undo link here)"
    else
      redirect_to @task, alert: 'Woops'
    end
  end

  private
    
    def params_task
      params.require(:task).permit(:endtime, :starttime, :title, :urgent)
    end

end
