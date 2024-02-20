class Room < ApplicationRecord

  has_many :messages, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :entries, dependent: :destroy

end
