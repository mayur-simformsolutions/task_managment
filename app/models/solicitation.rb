# frozen_string_literal: true
class Solicitation < ApplicationRecord
  #Assosications
  has_many :task_solicitations, dependent: :destroy
  has_many :tasks, through: :task_solicitations

  #Validations
  validates_presence_of :name
end
