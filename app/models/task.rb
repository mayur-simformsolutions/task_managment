# frozen_string_literal: true
class Task < ApplicationRecord
  include PgSearch::Model

  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  has_many :task_assignees, dependent: :destroy
  has_many :tasks, through: :task_assignees
  has_many :comments, dependent: :destroy
  has_many :task_labels
  has_many :labels, through: :task_labels
  has_many :documents, dependent: :destroy

  enum status: [:incompleted , :inprogress, :completed, :archive].freeze
  accepts_nested_attributes_for :documents, :reject_if => :all_blank, :allow_destroy => true

  scope :filter_by_dates, -> (custom_day) {
    tasks =
      case custom_day
      when "today"
        {due_date: Date.today.all_day}
      when "this week"
        {due_date: Date.today.beginning_of_week..Date.today.end_of_week}
      when "last week"
        {due_date: Date.today.last_week.beginning_of_week..Date.today.last_week.end_of_week}
      when "next week"
        ['due_date BETWEEN ? AND ?', Date.today.next_week, Date.today.next_week.end_of_week]
      when "upcoming"
        ['due_date > ?', Date.today]
      when "over due"
        ['due_date < ?', Date.today]
      when "no due date"
        {due_date: nil}
      end
    where(tasks)
  }

  pg_search_scope :filter_label, 
    associated_against: {labels: :name}, 
    using: {tsearch: {prefix: true}}

  pg_search_scope :filter_assignee, 
    associated_against: {users: :first_name},
    using: {tsearch: {prefix: true}}
  
  pg_search_scope :search, 
    against: [:title, :discription, :due_date],
    using: {tsearch: {prefix: true}}
  

  def upload_documents(params)
    params[:task][:documents_attributes].each do |attachment|
      documents.build(title: attachment.original_filename, attachment: attachment)
    end
  end

  def full_name
    first_name + last_name
  end
end
