class Project < ActiveRecord::Base
  has_many :duties
  has_many :users, through: :duties
  has_many :roles, through: :duties
  has_many :sprints
  has_many :stories
end
