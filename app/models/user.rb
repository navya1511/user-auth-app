class User < ApplicationRecord
    attr_accessor :password
    has_one_attached :profile_picture
   
    

    
    validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
    validates :password  , confirmation: true , length: { in: 6..20 } , on: :create

    before_save :encrypt_password
    
 
    def compare_password(password)
        return encrypt(password) == self.encrypted_password
            
    end

    def self.authenticate(email , password)
        user = find_by_email(email)
        return user if user && user.compare_password(password)
    end


    protected
    def encrypt_password
        return if password.blank?
        self.encrypted_password = encrypt(password)
    end
    
    
    def encrypt(string)
        Digest::SHA1.hexdigest(string)
    end
end
