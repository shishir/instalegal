class Client < User
  attr_accessible :name, :email, :password, :phone_number
  validates :name,  presence: true
  validates :email, presence: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, on: :create, message: "format is invalid" },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true
  before_save { self.email.downcase! }

  def generate_token(session_id)
    api_key = "25325972"        # Replace with your OpenTok API key.
    api_secret = "b22d32870ee14c88edca367fea8eb4fe49d4c4e4"  # Replace with your OpenTok API secret.
    opentok = OpenTok::OpenTokSDK.new api_key, api_secret
    opentok.generate_token :session_id => session_id, :role => OpenTok::RoleConstants::PUBLISHER, :connection_data => "username=#{self.name},level=4"
  end
end