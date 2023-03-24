class Booking < ApplicationRecord
    belongs_to :customer
    
    has_many :booking_vehicles
    has_many :vehicles, through: :booking_vehicles
    
    validates :booking_from, presence: true
    validates :booking_to, presence: true
    validates :vehicle_ids, presence: true
end 
