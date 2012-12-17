require 'spec_helper'

describe Datasource do
  
  it "has a valid factory" do
    expect(create(:datasource)).to be_valid
  end
  
  it "is invalid without a name" do
    expect(build(:datasource, name: nil)).to_not be_valid
  end
  
  it "is invalid without a datasource type" do
    expect(build(:datasource, datasource_type: nil)).to_not be_valid
  end  
  
  it "is invalid without a user association" do
    expect(build(:datasource, user: nil)).to_not be_valid
  end
  
  it "is invalid without a config" do
    expect(build(:datasource, config: nil)).to_not be_valid
  end  
  
end