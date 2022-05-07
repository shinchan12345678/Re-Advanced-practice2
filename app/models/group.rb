class Group < ApplicationRecord
  has_one_attached :image
  validates :group_name,presence: true
  validates :introduction,presence: true

  has_many :group_mambers,dependent: :destroy
  has_many :groups,dependent: :destroy

  belongs_to :owner_user ,class_name: "User",foreign_key: "owner_id"

  def get_image
    (image.atacched?) ? image : 'no_image.jpg'
  end

end