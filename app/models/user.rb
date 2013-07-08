class User < ActiveRecord::Base
  attr_accessible :email, :name
email_re=/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name,  :presence =>true,
  				    :length   =>{:maximum => 50}
  validates :email, :presence =>true,
  					:format   => {:with => email_re},
  					:uniqueness => {:case_sensitive =>false}


end
