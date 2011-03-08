require 'spec_helper'

describe Bugly::User do

  before do
    stub_get('/users.xml', 'users.xml')
  end

  let(:account) { Bugly::Account.new('example.bug.ly', 'abc123') }

  it "fetches all users" do
    users = account.users
    users.length.should == 5
  end

  it "fetches a specific user" do
    stub_get("/users/cfef23341551ebf73bbbca250ae8d9d649df103e.xml",
             "user_cfef23341551ebf73bbbca250ae8d9d649df103e.xml")

    user = account.user('cfef23341551ebf73bbbca250ae8d9d649df103e')
    user.full_name == 'Unassigned'
  end

end
