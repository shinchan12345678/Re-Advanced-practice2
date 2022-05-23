class GroupMail < ApplicationRecord
  belongs_to :group
  belongs_to :group_member
  validates :title, presence: true
  validates :body, presence: true
end
