class Booking < ApplicationRecord
    belongs_to :customer
    belongs_to :vehicle
    
    validates :booking_from, presence: true
    validates :booking_to, presence: true
    validates :vehicle_id, presence: true
    validates :booking_date, presence: true
    validate :booking_date_not_in_past
    validate :origin_address_and_destination_address_not_same

    def booking_date_not_in_past
      if booking_date < Time.now 
        errors.add(:booking_date, "can't be in the past")
      end
    end

    def origin_address_and_destination_address_not_same
      if booking_from == booking_to
        errors.add(:booking_from, "and destination address can't be same")
      end
    end
end 
