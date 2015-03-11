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
      render :action => "new"
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
      redirect_to :action => 'index'
    end
  end

  def destroy
    @task = Task.find params[:id]
    if @task.destroy
      flash[:success] = "#{@task.title} destroyed (add undo link here)"
      redirect_to :action => 'index'
    else
      flash[:error] = 'Woops'
    end
  end

  private
    
    def params_task
      params.require(:task).permit(:endtime, :starttime, :title, :urgent)
    end

end
