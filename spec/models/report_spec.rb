require 'spec_helper'

describe Report do
  
  it "has a valid factory" do
    expect(create(:report)).to be_valid
  end
  
  it "is invalid without a title" do
    expect(build(:report, title: nil)).to_not be_valid
  end
  
  it "is valid without a description" do
    expect(build(:report, description: nil)).to be_valid
  end
  
  it "is valid without cache_time" do
    expect(build(:report, cache_time: nil)).to be_valid
  end
  
  it "is invalid without a datasource" do
    expect(build(:report, datasource: nil)).to_not be_valid
  end
  
  
  describe "sharing config behavior" do
    
    before :each do
      @report = create(:report)
      @report.sharing_enabled.should_not eq true
    end
    
    context "sharing config" do
      
      it "has sharing disabled by default" do
        @report.sharing_enabled.should_not eq true
      end
    
      it "disabled sharing via disable_share" do
        @report.disable_sharing
        @report.sharing_enabled.should eq false
      end
      
      it "enables sharing via enable_sharing method" do
        @report.enable_sharing ''
        @report.sharing_enabled.should eq true
      end
    end
    
  end
  
end