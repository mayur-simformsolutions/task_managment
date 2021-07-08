# frozen_string_literal: true
class Api::V1::CommentsController < Api::V1::AuthenticatedController
  before_action :set_task, only: [:index, :create, :update, :destroy]
  before_action :set_comment, only: [:update, :destroy]

  # GET /api/v1/tasks/:task_id/comments
  def index
    begin
      comments = @task.comments
    rescue => e
      render_exception(e, 422) && return
    end
    json_response(CommentSerializer.new(comments).serializable_hash[:data].map {|comment| comment[:attributes]})
  end

  # POST /api/v1/tasks/:task_id/comments
  def create
    begin
      comment = @task.comments.create!(comments_params.merge(user: current_user))
    rescue => e 
      render_exception(e, 422) && return
    end
    json_response(CommentSerializer.new(comment).serializable_hash[:data][:attributes])
  end

  # PATCH /api/v1/tasks/:task_id/comments/:id
  def update
    begin
      @comment.update!(comments_params)
    rescue => e 
      render_exception(e, 422) && return
    end
    json_response(CommentSerializer.new(@comment).serializable_hash[:data][:attributes])
  end

  # DELETE /api/v1/tasks/:task_id/comments/:id
  def destroy
    begin
      @comment.destroy
    rescue => e 
      render_exception(e, 422) && return
    end
    render json: { success: true, data: {}, errors: [] }, status: 200
  end

  private

  def comments_params
    params.require(:comment).permit(:comment)
  end

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_comment
    @comment = @task.comments.find(params[:id])
  end
end
