require 'spec_helper'

describe Project do
  
  it "has a valid factory" do
    expect(build(:project)).to be_valid
  end
  
  it "is invalid without a name" do
    expect(build(:project_without_name)).to_not be_valid
  end
  
  it "is invalid without a user" do
    expect(build(:project_without_user)).to_not be_valid
  end
  
  it "is valid with a blank description" do
    expect(build(:project_without_description)).to be_valid
  end
  
end
