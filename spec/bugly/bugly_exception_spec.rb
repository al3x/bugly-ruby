require 'spec_helper'

describe BuglyException do
  let(:account) { Bugly::Account.new("example.bug.ly", "abc123") }

  it 'should return for a bad request' do
    stub_post('/issues.xml', 'issue_errors_on_creation.xml')

    new_issue = Bugly::Issue.new

    # this will error because we haven't set a title
    lambda { account.create_issue(new_issue) }.should raise_error(BuglyException, /Title/)
  end
end
