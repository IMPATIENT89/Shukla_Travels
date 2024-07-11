class Hoste < ApplicationRecord
    has_secure_password
    has_many :vehicles, dependent: :destroy


    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email, presence: true,
                        uniqueness: { case_sensitive: false },
                        length: { maximum: 105 },
                        format: { with: VALID_EMAIL_REGEX }
    validates :phone, presence: true,
                        uniqueness: { case_sensitive: false },
                        length: { maximum: 10}
    validates :no_of_cars, presence: true,
                        length: { maximum: 2}
    validates :host_full_name, presence: true,
                        length: { maximum: 50}
end
