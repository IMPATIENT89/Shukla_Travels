class BookingVehicle < ApplicationRecord
    belongs_to :booking
    belongs_to :vehicle
end
