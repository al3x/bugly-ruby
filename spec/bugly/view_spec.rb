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
  
  it "fetches a specific view" do
    stub_get('/views/242.xml', 'view_242.xml')

    view = account.view(242)
    view.should be_kind_of(Bugly::View)
  end
end
