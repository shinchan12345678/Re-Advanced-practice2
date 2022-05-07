class Group < ApplicationRecord
  has_one_attached :image
  has_many :group_mambers,dependent: :destroy
  has_many :groups,dependent: :destroy

  has_one :owner_user ,class_name: "User",foreign_key: "owner_id"
end
