class Bug < ApplicationRecord

  self.inheritance_column = nil  # This tells Rails not to use the 'type' column for STI

  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  belongs_to :developer, class_name: 'User', foreign_key: 'developer_id', optional: true
  belongs_to :project

  validates :title, presence: true, uniqueness: { scope: :project_id, message: "should be unique within the project" }
  validates :status, :bug_type, presence: true

  mount_uploader :screenshot, ScreenshotUploader


  BUG_TYPES = ['feature', 'bug']
  BUG_STATUSES = ['new', 'started', 'resolved']
  FEATURE_STATUSES = ['new', 'started', 'completed']

  validates :type, inclusion: { in: BUG_TYPES }
  validates :status, inclusion: { in: BUG_STATUSES + FEATURE_STATUSES }


end
  