# frozen_string_literal: true
class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :user
end
