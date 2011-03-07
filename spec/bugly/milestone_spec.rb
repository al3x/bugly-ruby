require 'spec_helper'

describe Bugly::Milestone do
  let(:account) { Bugly::Account.new("example.bug.ly", "abc123") }
  
  it "fetches all milestones" do
    stub_get("/milestones.xml", "milestones.xml")

    milestones = account.milestones
    milestones.length.should == 2
    
    perfect = milestones.first
    perfect.should be_kind_of(Bugly::Milestone)
    perfect.name.should == "it's perfect"
  end
  
  it "fetches a specific milestone" do
    stub_get('/milestones/154.xml', 'milestone_154.xml')
    
    milestone = account.milestone(154)
    milestone.should be_kind_of(Bugly::Milestone)
    milestone.id.should == 154
    milestone.name.should == "it's perfect"
  end
end
