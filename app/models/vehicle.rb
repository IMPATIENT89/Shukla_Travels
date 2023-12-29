class Vehicle < ApplicationRecord
    belongs_to :hoste
    has_many :bookings
    has_one_attached :vehicle_image
    
    validates :vehicle_no, presence: true,uniqueness: { case_sensitive: false }, length: { maximum: 15 }
    validates :registration_no, presence: true,uniqueness: { case_sensitive: false }
    validates :car_name, presence: true
end
