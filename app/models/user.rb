class User < ActiveRecord::Base
  has_many :topics
  has_many :posts, :inverse_of => :user, :dependent => :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :login, :admin, :import_id
  attr_accessor :login

  def to_s
    self.username
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

end
