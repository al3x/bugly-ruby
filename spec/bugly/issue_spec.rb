require 'spec_helper'

describe Bugly::Issue do

  before do
    stub_get('/projects.xml', 'projects.xml')
    stub_get('/milestones/154.xml', 'milestone_154.xml')
  end

  let(:account) { Bugly::Account.new('example.bug.ly', 'abc123') }
  let(:project) { account.projects.select { |p| p.id == 146 }.first }
  let(:milestone) { account.milestone(154) }
  
  it 'fetches all issues' do
    stub_get('/issues.xml', 'issues.xml')
    
    issues = account.issues
    issues.length.should == 12
  end

  it 'fetches a specific issue' do
    stub_get('/issues/1.xml', 'issue_1.xml')

    issue = account.issue(1)
    issue.should be_a(Bugly::Issue)
    issue.id.should == '1'
  end

  it 'fetches issues for a specific project' do
    stub_get(project.api_issues_url, 'project_146_issues.xml')
  
    issues = project.issues
    issues.length.should == 1
    
    first_issue = issues.first
    first_issue.should be_a(Bugly::Issue)
    first_issue.id.should == '5'
  end
  
  it 'fetches issues for a specific milestone' do
    stub_get(milestone.milestone_issues_url, 'milestone_154_issues.xml')

    issues = milestone.issues
    issues.length.should == 2
  end
  
end
