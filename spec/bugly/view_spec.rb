require 'spec_helper'

describe Bugly::View do

  let(:account) { Bugly::Account.new('example.bug.ly', 'abc123') }
  
  it "fetches all views" do
    stub_get("/views.xml", "views.xml")

    views = account.views
    views.length.should == 3
    
    unassigned = views.first
    unassigned.should be_kind_of(Bugly::View)
    unassigned.name.should == 'Unassigned'
  end
end
