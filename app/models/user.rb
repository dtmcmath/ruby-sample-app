require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  email_regex = /\A[\w\+\-\.]+@[a-z\d\-\.]+\.[a-z]+\Z/i

  validates :name, :presence => true,
                   :length => { :maximum => 50 }
  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
  ## Automatically creates the virtual attribute 'password_confirmation'
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 6..40 }
                       
  before_save :encrypt_password
  
  ## Return true if the users's password matches the submitted password
  def has_password?(submitted_password)
    return encrypt(submitted_password) == encrypted_password
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
    # else
    return nil
  end
  
  private
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(self.password)
    end
    
    def encrypt(str)
      return secure_hash( "#{salt}--#{str}" )
    end
    
    def make_salt
      secure_hash( "#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(str)
      Digest::SHA2.hexdigest(str)
    end
end
