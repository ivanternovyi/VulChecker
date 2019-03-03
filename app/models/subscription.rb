class Subscription < ApplicationRecord
  belongs_to :user, optional: true

  validates :telegram_id, presence: true
  validates :name, presence: true
end
