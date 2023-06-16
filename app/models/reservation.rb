class Reservation < ApplicationRecord
    validates :firstname, presence: true
    validates :lastname, presence: true
    validates :reservation_date, presence: true
  
  end
  