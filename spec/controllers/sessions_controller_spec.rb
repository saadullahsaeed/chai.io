require 'spec_helper'

describe SessionsController do
  
  describe "POST #create" do
    
    context "with valid credentials" do
      it "stores user_id in session"
      it "redirects to the reports page"
    end
    
    context "with valid invalid credentials" do
      it "adds errror message to flash alert"
      it "redirects to the home page"
    end
  end
  
end