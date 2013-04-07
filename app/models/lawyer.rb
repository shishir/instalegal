class Lawyer < User
  attr_accessible :name, :email, :password, :phone_number, :avatar, :description
  has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => "/assets/missing.png"

  validates :name,  presence: true
  validates :email, presence: true,
                     format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, on: :create, message: "format is invalid" },
                     uniqueness: { case_sensitive: false }
  validates :password, presence: true
  validates :description, :length => { :maximum => 200 }, presence: true
  before_save { self.email.downcase! }

   def create_opentok_session(remote_addr)
     api_key = "25325972"        # Replace with your OpenTok API key.
     api_secret = "b22d32870ee14c88edca367fea8eb4fe49d4c4e4"  # Replace with your OpenTok API secret.
     opentok = OpenTok::OpenTokSDK.new api_key, api_secret
     session_properties = {OpenTok::SessionPropertyConstants::P2P_PREFERENCE => "enabled"}
     session = opentok.create_session remote_addr
     token = opentok.generate_token :session_id => session.session_id, :role => OpenTok::RoleConstants::PUBLISHER, :connection_data => "username=#{self.name},level=4"
     self.opentok_session_id = session.session_id
     self.opentok_token_id = token
     self.save!
   end
end
