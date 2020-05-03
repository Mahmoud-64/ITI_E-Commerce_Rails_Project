class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:login]

  enum role: [:buyer, :seller, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :buyer
  end

  validates :username, presence: true, uniqueness: { case_sensitive: false }     
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

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
end