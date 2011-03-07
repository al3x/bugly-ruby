require 'spec_helper'

describe Bugly::Account do
  let(:account) { Bugly::Account.new("example.bug.ly", "abc123") }

  it 'initializes' do
    account.should be_kind_of(Bugly::Account)
  end
end
