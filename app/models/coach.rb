require 'digest/sha2'
class Coach < ActiveRecord::Base
  
   has_many :players
  validates :name,:team_name, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :password , :presence => true, :confirmation => true, :if => Proc.new{|user| user.validate_password == true}
  # validate :password_must_be_present
  # attr_accessor :password_confirmation
  attr_accessor :password, :validate_password
  
   def self.authenticate(email, password)
      if user = find_by_email(email)
        if user.encrypted_password == Digest::SHA2.hexdigest(password)
           
          user
        end
      end
    end

  def password=(password)
    @password =password
    if password.present?
      self.encrypted_password = Digest::SHA2.hexdigest(password)
    end
  end

  private

  def password_must_be_present
    errors.add(:password, "Missing password") unless encrypted_password?
  end


end

