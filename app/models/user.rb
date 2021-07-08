class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable,:database_authenticatable, :registerable, :validatable, :confirmable

  has_many :tasks, class_name: 'Task', foreign_key: 'creator_id', dependent: :destroy
  has_many :task_assignees, dependent: :destroy
end
