class Vehicle < ApplicationRecord
    belongs_to :hoste
    has_many :booking_vehicles
    has_many :bookings, through: :booking_vehicles

    
    validates :vehicle_no, presence: true,uniqueness: { case_sensitive: false }, length: { maximum: 15 }
    validates :registration_no, presence: true,uniqueness: { case_sensitive: false }
    validates :car_name, presence: true
end
