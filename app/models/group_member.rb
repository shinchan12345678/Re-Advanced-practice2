class GroupMember < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :group_mails
  validates_uniqueness_of :group_id, scope: :user_id
end
