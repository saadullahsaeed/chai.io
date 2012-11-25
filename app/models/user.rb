class User < ActiveRecord::Base
  has_many :reports, :dependent => :destroy
  has_many :datasources, :dependent => :destroy
  
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create
end
