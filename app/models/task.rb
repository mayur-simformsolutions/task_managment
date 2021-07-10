# frozen_string_literal: true
class Task < ApplicationRecord
  has_paper_trail
  include PgSearch::Model

  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  has_many :task_assignees, dependent: :destroy
  has_many :users, through: :task_assignees
  has_many :comments, dependent: :destroy
  has_many :task_labels
  has_many :labels, through: :task_labels
  has_many :documents, dependent: :destroy
  has_many :task_solicitations, dependent: :destroy
  has_many :solicitations, through: :task_solicitations
  #Callbake
  before_save :save_event
  before_update :update_event

  enum status: [:incompleted , :inprogress, :completed, :archive].freeze
  accepts_nested_attributes_for :documents, :reject_if => :all_blank, :allow_destroy => true

  scope :sort_by_title, -> (query) {order(query)}
  scope :sort_by_status, -> (query) { order(status: "#{query}".to_sym) }
  scope :sort_by_assigness, -> (query) { joins(:users).order("users.first_name #{query}") } # TODO: need to do on fullname
  scope :sort_by_labels, -> (query) { joins(:labels).order("labels.name #{query}") }
  scope :sort_by_solicitations, -> (query) {  joins(:solicitations).order("solicitations.name #{query}") }

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
  
  pg_search_scope :filter_by_status, 
    against: [:status],
    using: {tsearch: {prefix: true}}
  
  pg_search_scope :filter_by_document, 
    associated_against: {documents: :title},
    using: {tsearch: {prefix: true}}

  pg_search_scope :filter_by_solicitations, 
    associated_against: {solicitations: :name},
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

  def save_event
    self.paper_trail_event = "created task."
  end

  def update_event
    self.paper_trail_event = "updated task."
  end
end
