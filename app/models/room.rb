class Room < ApplicationRecord
  has_many :room_relations, dependent: :destroy
  has_many :direct_messages, dependent: :destroy

  # def room_relations_create(other_user)
  #   room_relations.create(user_id: other_user.id)
  # end
end
