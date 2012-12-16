class HomeController < ApplicationController
  
  skip_before_filter :require_login
  before_filter :auto_login
  
  def index
  end
  
end
