# frozen_string_literal: true
class TaskLabel < ApplicationRecord
  #Assosications
  belongs_to :task
  belongs_to :label
end
