# frozen_string_literal: true
class Api::V1::TasksController < Api::V1::AuthenticatedController
  before_action :set_task, only: [:update, :destroy, :show, :status]

  # GET  /api/tasks
  def index
    begin
      tasks = Tasks.all
      tasks = tasks.paginate(page: params[:page], per_page: 10)
    rescue => e
      render_exception(e, 422) && return
    end
    json_response(TaskSerializer.new(tasks).serializable_hash[:data].map {|task| task[:attributes]},MetaGenerator.new.generate!(tasks))
  end

  #POST /api/tasks
  def create
    begin
      task = Task.create!(task_params)
    rescue => e 
      render_exception(e, 422) && return
    end
    json_response(TaskSerializer.new(task).serializable_hash[:data][:attributes])
  end

  #PUT /api/tasks/:id
  def update  
    begin
      @task.update!(task_params)
    rescue => e 
      render_exception(e, 422) && return
    end
    json_response(TaskSerializer.new(@task).serializable_hash[:data][:attributes])
  end

  #GET /api/tasks/:id
  def show
    json_response(TaskSerializer.new(@task).serializable_hash[:data][:attributes])
  end

  #DELETE /api/tasks/:id
  def destroy
    begin
      @task.destroy
    rescue => e 
      render_exception(e, 422) && return
    end
    render json: { success: true, data: {}, errors: [] }, status: 200
  end

   #PUT /api/tasks/:id/status
   def status
    begin
      @task.update!(status: task_params[:status])
    rescue => e 
      render_exception(e, 422) && return
    end
    json_response(TaskSerializer.new(@task).serializable_hash[:data][:attributes])
  end

  #private methods
  private

  def task_params
    params.require(:task).permit(:title, :due_date, :description, :status)
  end
  
  def set_task
    @task = Task.find(params[:id])
  end
end 