class Booking < ApplicationRecord
    belongs_to :customer
    belongs_to :vehicle
    
    validates :booking_from, presence: true
    validates :booking_to, presence: true
    validates :vehicle_id, presence: true
    validate :booking_date_not_in_past

    def booking_date_not_in_past
      if booking_date.present? && booking_date < Time.now
        errors.add(:booking_date, "can't be in the past")
      end
    end
end 
