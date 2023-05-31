class Reservation < ApplicationRecord
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :reservation_date, presence: true
  end
  