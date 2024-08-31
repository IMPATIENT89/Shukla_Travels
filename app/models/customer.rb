class Customer < ApplicationRecord
    has_many :bookings, dependent: :destroy
    has_secure_password
    has_one_attached :profile_image

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email, presence: true

    validates :customer_full_name, presence: true,
                        length: { maximum: 50}    

end
