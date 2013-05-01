class TasksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_story

  authorize_resource

  def new
    @task = Task.new
  end

  def create
    if @story.tasks.create(task_params)
      redirect_to story_path(@story.project, @story)
    else
      render :new
    end
  end

  private

    def set_story
      @story = Story.find(params[:story_id])
    end

    def task_params
      params.require(:task).permit(:name, :description)
    end
end
