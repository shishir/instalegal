class Lawyer < User
  attr_accessible :name, :email, :password, :phone_number
  validates :name,  presence: true
  validates :email, presence: true,
                     format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, on: :create, message: "format is invalid" },
                     uniqueness: { case_sensitive: false }
   validates :password, presence: true
   before_save { self.email.downcase! }
end
