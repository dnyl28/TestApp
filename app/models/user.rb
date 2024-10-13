class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum user_type: { manager: 'manager', developer: 'developer', qa: 'qa' }

  has_many :created_bugs, class_name: 'Bug', foreign_key: 'creator_id'
  has_many :assigned_bugs, class_name: 'Bug', foreign_key: 'developer_id'
  has_many :project_users
  has_many :projects, through: :project_users

end
