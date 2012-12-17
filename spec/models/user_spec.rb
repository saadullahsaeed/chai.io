require 'spec_helper'

describe User do
  
  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end
  
  it "is invalid without a name" do
    expect(build(:user, name: nil)).to_not be_valid
  end

  it "is invalid without an email" do
    expect(build(:user, email: nil)).to_not be_valid
  end
  
  it "is invalid with a duplicate email address" do
    create(:user, email: "saad@peanutlabs.com")
    expect(build(:user, email: "saad@peanutlabs.com")).to_not be_valid
  end
  
  it "is password hashed" do
    expect(create(:user, password: "saad")).to_not eq "saad"
  end
  
end