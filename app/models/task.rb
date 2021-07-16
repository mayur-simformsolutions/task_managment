# frozen_string_literal: true
class Task < ApplicationRecord
  has_paper_trail
  include PgSearch::Model

  #Assosications
  belongs_to :creator, class_name: :User, foreign_key: :creator_id
  has_many :task_assignees, dependent: :destroy
  has_many :users, through: :task_assignees
  has_many :comments, dependent: :destroy
  has_many :task_labels
  has_many :labels, through: :task_labels
  has_many :documents, dependent: :destroy
  has_many :task_solicitations, dependent: :destroy
  has_many :solicitations, through: :task_solicitations

  #Callbacks
  before_save :save_event
  before_update :update_event

  enum status: [:incompleted , :inprogress, :completed, :archive, :unarchive].freeze
  accepts_nested_attributes_for :documents, reject_if: :all_blank, allow_destroy: true

  #Validations
  validates_presence_of :title, :description

  #Scopes
  scope :sort_by_title,         ->   (query)   { order(title: query.to_sym) }
  scope :sort_by_status,        ->   (query)   { order(status: query.to_sym) }
  scope :sort_by_assigness,     ->   (query)   { includes(:users).order("users.first_name "+ query) }
  scope :sort_by_labels,        ->   (query)   { includes(:labels).order("labels.name "+ query) }
  scope :sort_by_solicitations, ->   (query)   { includes(:solicitations).order("solicitations.name " + query) }
  scope :filter_by_status,      ->   (query)   { where(status: query) }
  scope :created_by_filter,     ->   (user_id) {​​​ where(creator_id:user_id) }​​​
  scope :assigned_to_me_filter, ->   (user_id) {​​​ joins(:task_assignees).where("task_assignees.user_id = ?", user_id) }​​​
  scope :filter_by_user,        ->   (query, user_id) {​​​ 
    if query == 'created_by'
      created_by_filter(user_id)
    elsif query == 'assigned_by'
      assigned_to_me_filter(user_id)
    end
  }​​​

  scope :filter_by_dates,       ->   (custom_day) {
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

  # Filter by lable
  pg_search_scope :filter_label, 
    associated_against: {labels: :name}, 
    using: {tsearch: {prefix: true}}

  # Filter by assignee
  pg_search_scope :filter_assignee, 
    associated_against: {users: :first_name},
    using: {tsearch: {prefix: true}}
  
  # Filter by document
  pg_search_scope :filter_by_document, 
    associated_against: {documents: :title},
    using: {tsearch: {prefix: true}}

  # Filter by solicitations
  pg_search_scope :filter_by_solicitation, 
    associated_against: {solicitations: :name},
    using: {tsearch: {prefix: true}}
  
  # Filter by search by title, discription, and due date
  pg_search_scope :search, 
    against: [:title, :description, :due_date],
    using: {tsearch: {prefix: true}}
  

  # @param [FileObject] Task's documents
  def upload_documents(params)
    params[:task][:documents_attributes].each do |attachment|
      documents.build(title: attachment.original_filename, attachment: attachment)
    end
  end

  # @Set [string] Sets the tasks events
  def save_event
    self.paper_trail_event = "created task."
  end

  def update_event
    self.paper_trail_event = "updated task."
  end
end
