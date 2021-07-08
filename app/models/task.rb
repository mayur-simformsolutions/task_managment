# frozen_string_literal: true
class Task < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  has_many :task_assignees, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :task_labels
  has_many :labels, through: :task_labels
  has_many :documents, dependent: :destroy

  enum status: [:incompleted , :inprogress, :completed, :archive].freeze
  accepts_nested_attributes_for :documents, :reject_if => :all_blank, :allow_destroy => true


  def upload_documents(params)
    params[:task][:documents_attributes].each do |attachment|
      documents.build(title: attachment.original_filename, attachment: attachment)
    end
  end
end
