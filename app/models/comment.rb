# frozen_string_literal: true
class Comment < ApplicationRecord
  #Assosications
  belongs_to :task
  belongs_to :user

  #Validations
  validates_presence_of :comment
end
