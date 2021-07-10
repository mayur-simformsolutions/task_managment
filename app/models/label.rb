# frozen_string_literal: true
class Label < ApplicationRecord
  #Assosications
  has_many :task_labels
  has_many :tasks, through: :task_labels

  #Validations
  validates_presence_of :name
end
