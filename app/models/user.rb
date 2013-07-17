# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  email             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  encryted_password :string(255)
#  salt              :string(255)
#  admin             :boolean          default(FALSE)
#

class User < ActiveRecord::Base
	  attr_accessor :password	
	  attr_accessible :email, :name, :password, :password_confirmation
	  #assocai...
	  has_many :microposts,            :dependent    =>:destroy
	  has_many :relationshps,           :dependent    =>:destroy,
	   						           :foreign_key  =>"follower_id"
	  has_many :reverse_relationshps,   :dependent    =>:destroy,
	  						           :foreign_key  =>"followed_id",
	  						           :class_name   =>"Relationshp"
	  has_many :following,             :through      =>:relationshps,
	  								   :source       =>:followed
	  has_many :followers,             :through      =>:reverse_relationshps,
	  								   :source       =>:follower
	 
	  email_re=/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	  validates :name,     :presence 		=> true,
	  				       :length   		=> {:maximum => 50}
	  validates :email,    :presence 		=> true,
	  					   :format  	    => {:with => email_re},
	  					   :uniqueness	    => {:case_sensitive => false}

	  validates :password, :presence        => true,
						   :confirmation    => true,
					  	   :length          => {:within => 6..40}
	 
	 before_save :encrypt_password

	def has_password?(submitted_password)
		encryted_password==encrypt(submitted_password)
	end

	def feed
		#feed show
		#Micropost.where("user_id = ?",id)
				Micropost.from_users_followed_by(self)
	end
	def following?(followed)
		relationshps.find_by_followed_id(followed)
	end
	def follow!(followed)
		relationshps.create!(:followed_id =>followed.id)
	end
	def unfollow!(followed)
		relationshps.find_by_followed_id(followed).destroy	
	end	


			class << self
				def authenticate(email,submitted_password)
				user=find_by_email(email)
				#(user && user.has_password?(submitted_password))? user :nil
				return nil if user.nil?
				return user if user.has_password?(submitted_password)
				end

				def authenticate_with_salt(id,cookie_salt)
					user=find_by_id(id)
					(user && user.salt==cookie_salt)? user :nil
				end
			end

	 private
	 def encrypt_password
	 	self.salt=make_salt if new_record?
	 	self.encryted_password=encrypt(password)
	 end

	 def encrypt(string)
	 	secure_hash("#{salt}--#{string}")
	 end

	 def make_salt
	 	secure_hash("#{Time.now.utc}--#{password}")
	 end

	 def secure_hash(string)
		Digest::SHA2.hexdigest(string)
	 end

end
