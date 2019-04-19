=begin
  Class: User

  Functions:
    login?(email, password)
    from_email(email)
    register(email, password, type)
    delete_account()
    set_email(new_email)
    set_password(new_password)
=end

class User < ApplicationRecord

  before_save {self.email = email.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
		format: {with: VALID_EMAIL_REGEX},
		uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}
  #has_one :organizations, dependent: :destroy
  has_many :favorite_opportunities, foreign_key: 'email', dependent: :destroy
  has_many :favorites, through: :favorite_opportunities, source: :opportunity

=begin
 Function: login?()

 Parameters:
  String: input email
  String: input password

 Post-condition:
  return boolean: whether email and password match a user account
=end
  def self.login?(email, password)
    User.exists?(Email: email,
                 Password: password)
  end

=begin
 Function: from_email()

 Parameters:
  String: key of the user account to find

 Post-condition:
  return User: model of the user account to find
=end
  def self.from_email(email)
    User.find(email)
  end

=begin
 Function: register()

 Parameters:
  String: email of the new volunteer account
  String: password of the new volunteer account
  integer: type of account (0 = CELR, 1 = Organization, 2 = Volunteer)

 Post-condition:
  if account has not already been made, add new account
    to user table
=end
  def self.register(email, password, type)
    if !User.exists?(Email: email) 
      User.create(Email: email,
                  Password: password,
                  Type: type)
    end
  end

=begin
 Function: delete_account()

 Parameters:

 Post-condition:
  if account is not CELR, delete account
=end
  def delete_account
    if !Type == 0
      User.find(Email).destroy
    end
  end

=begin
 Function: set_email()

 Parameters:
  String: new email for account

 Post-condition:
  update email for account
=end
  def set_email(new_email)
    update(Email: new_email)
  end

=begin
 Function: set_password()

 Parameters:
  String: new password for account

 Post-condition:
  update password for account
=end
  def set_password(new_password)
    update(Password: new_password)
  end

end
