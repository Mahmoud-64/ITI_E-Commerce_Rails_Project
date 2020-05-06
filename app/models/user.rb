class User < ApplicationRecord
  has_one_attached :avatar
  validate :image_type
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        #  :confirmable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:login]


  #Adding roles to user
  enum role: [:buyer, :seller, :admin]
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
    self.role ||= :buyer
  end

  #Validate user input
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validates :email, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    message: "is not a valid email format"
  }


  #handle signup with username and email
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  #handle login using username/email
  attr_writer :login
  def login
    @login || self.username || self.email
  end

  delegate :can?, :cannot?, to: :ability
  def ability
    @ability ||= Ability.new(self)
  end


  private

  def image_type
     if avatar.attached?
       if !avatar.content_type.in?(%('image/jpeg image/png image/jpg'))
         errors.add(:avatar, "needs to be a jpeg, jpg, png only!")
       end
     end
  end

end
