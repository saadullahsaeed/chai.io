class User < ActiveRecord::Base
  has_many :reports, :dependent => :destroy
  has_many :datasources, :dependent => :destroy
  has_many :projects, :dependent => :destroy
  
  attr_accessor :new_password, :new_password_confirm
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create
  
  validates_presence_of :name, :email
  validates_uniqueness_of :email
end
