require 'spec_helper'

describe Bugly::Account do
  let(:account) { Bugly::Account.new("example.sifterapp.com", "abc123") }
  
  it "fetches all projects" do
    stub_get("/projects.xml", "projects.xml")

    projects = account.projects

    projects.length.should == 2
    projects.first.should be_kind_of(Bugly::Project)
  end

end
