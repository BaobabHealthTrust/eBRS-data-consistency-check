require 'couchrest_model'

class User < CouchRest::Model::Base
  
  property :username, String
  property :first_name, String
  property :last_name, String
  property :email, String
  property :password_hash, String
  property :active, TrueClass, :default => true
  property :notify, TrueClass, :default => false
  property :role, String
  property :creator, String
  property :void_reason, String
  property :_rev, String

  timestamps!

  cattr_accessor :current

  def has_role?(role_name)
    self.current.role == role_name ? true : false
  end

  design do
    view :by_active
    view :by_username
    view :by_username_and_active
    view :by_role
    view :by_created_at
    view :by_updated_at

  end

  before_save do |pass|
    unless self.password_hash.blank?
      self.password_hash = BCrypt::Password.create(self.password_hash) 
    end
  end

  def password_matches?(plain_password)
    not plain_password.nil? and self.password == plain_password
  end

  def password
    @password ||= BCrypt::Password.new(password_hash)
  rescue BCrypt::Errors::InvalidHash
    Rails.logger.error "The password_hash attribute of User[#{self.username}] does not contain a valid BCrypt Hash."
    return nil
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def confirm_password
    password_hash
  end
  
  def admin?
    ((self.role.strip.downcase.match(/system administrator/i).blank?) == false ? true : false)
  end
  

end
