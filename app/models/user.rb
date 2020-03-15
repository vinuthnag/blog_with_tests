require 'digest/sha1'
class User < ApplicationRecord
	 attr_accessor :password
	 validates :name,:email, presence: true
	 validates :password, confirmation: true
	 validates :email, uniqueness:true
	 before_save :encrypt_password
	 has_many :posts, dependent: :destroy
	 has_many :comments, dependent: :destroy
	 has_one_attached :avatar

	def self.authenticate(email,password)
	    user = find_by_email(email)
	    if user && user.password_hash == Digest::SHA1.hexdigest(password.to_s)
	        user
	    else
	        nil
	    end
	end

    def encrypt_password
	    unless self.password.blank?
	      self.password_hash = Digest::SHA1.hexdigest(self.password.to_s)
	      self.password = nil
	    end
	    return true 
    end
end
