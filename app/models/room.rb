class Room < ApplicationRecord
  has_many :room_relations,dependent: :destroy
end
