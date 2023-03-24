class Customer < ApplicationRecord

    has_many :bookings, dependent: :destroy
    has_secure_password

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email, presence: true,
                        uniqueness: { case_sensitive: false },
                        length: { maximum: 105 },
                        format: { with: VALID_EMAIL_REGEX }
    validates :phone, presence: true,
                        uniqueness: { case_sensitive: false },
                        length: { maximum: 10}

    validates :customer_full_name, presence: true,
                        length: { maximum: 50}
                        
end
