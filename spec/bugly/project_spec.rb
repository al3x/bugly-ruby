require 'spec_helper'

describe Bugly::Project do

  before do
    stub_get('/projects.xml', 'projects.xml')
  end

  let(:account) { Bugly::Account.new('example.bug.ly', 'abc123') }
  let(:project) { account.projects.select { |p| p.id == 145 }.first }
  
  it "fetches all projects" do
    stub_get("/projects.xml", "projects.xml")

    projects = account.projects
    projects.length.should == 3
    
    inbox_project = projects.first
    inbox_project.should be_kind_of(Bugly::Project)
    inbox_project.name.should == 'Inbox'
  end
  
  it "initializes from fixture" do
    project.id.should == 145
    project.name.should == "Find a bug tracker that doesn't suck"
  end  
end
