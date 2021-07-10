# frozen_string_literal: true
class Api::V1::TasksController < Api::V1::AuthenticatedController
  before_action :set_task, only: [:update, :destroy, :show, :status]

  # GET  /api/tasks
  def index
    begin
      tasks = Task.all.includes(:users, :documents, :comments, :labels)
      
      #Searching and filtering
      tasks = tasks.search(params[:query]) if params[:query].present?
      tasks = tasks.filter_assignee(params[:user]) if params[:user].present?
      tasks = tasks.filter_label(params[:label]) if params[:label].present?
      tasks = tasks.filter_by_status(params[:status]) if params[:status].present?
      tasks = tasks.filter_by_document(params[:document]) if params[:document].present?
      tasks = tasks.filter_by_solicitations(params[:solicitations]) if params[:solicitations].present?
      # sorting
      tasks = tasks.sort_by_title(params[:sort_title]) if params[:sort_title].present?
      tasks = tasks.sort_by_assigness(params[:sort_assigness]) if params[:sort_assigness].present?
      tasks = tasks.sort_by_labels(params[:sort_labels]) if params[:sort_labels].present?
      tasks = tasks.sort_by_solicitations(params[:sort_solicitations]) if params[:sort_solicitations].present?

      tasks = tasks.paginate(page: params[:page], per_page: 10)
    rescue => e
      render_exception(e, 422) && return
    end
    json_response(TaskSerializer.new(tasks).serializable_hash[:data].map {|task| task[:attributes]},MetaGenerator.new.generate!(tasks))
  end

  #POST /api/tasks
  def create
    begin
      task = current_user.tasks.create!(task_params)
      task.upload_documents(params) if params[:task][:documents_attributes]
      task.save!
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
    params.require(:task).permit(:title, :due_date, :description, :status , user_ids: [], label_ids: [], solicitation_ids:[], documents_attributes: [:id, :attachment])
  end
  
  def set_task
    @task = Task.find(params[:id])
  end
end 
