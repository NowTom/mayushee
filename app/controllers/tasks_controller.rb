class TasksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_story, only: [:new, :create]

  authorize_resource

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = @story.tasks.build(task_params)
    if @task.save
      redirect_to story_path(@story)
    else
      render :new
    end
  end

  def update
    @task = Task.find(params[:id])

    if @task.update_attributes(task_params)
      redirect_to story_path(@task.story)
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @story = @task.story
    @task.destroy
    redirect_to story_path(@story)
  end

  private

    def set_story
      @story = Story.find(params[:story_id])
    end

    def task_params
      params.require(:task).permit(:name, :description, :original_estimation)
    end
end
