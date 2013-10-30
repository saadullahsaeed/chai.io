class User < ActiveRecord::Base
  has_many :projects, :dependent => :destroy
  has_many :reports, :dependent => :destroy
  has_many :datasources, :dependent => :destroy

  
  attr_accessor :new_password, :new_password_confirm
  has_secure_password
  validates_presence_of :password, :on => :create
  
  validates_presence_of :name, :email
  validates_uniqueness_of :email


  def lock
    self.locked = true
    save
  end


  def unlock
    self.locked = false
    save
  end
  
end
