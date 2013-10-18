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
    n = Time.now.to_i
    create(:user, email: "saad#{n}@peanutlabs.com")
    expect(build(:user, email: "saad#{n}@peanutlabs.com")).to_not be_valid
  end
  
  it "authenticates valid password" do
    create(:user).authenticate("saad").should_not eq false
  end
  
  it "does not authenticate invalid password" do
    create(:user).authenticate("daas").should eq false
  end
end