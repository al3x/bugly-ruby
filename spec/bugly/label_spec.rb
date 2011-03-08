require 'spec_helper'

describe Bugly::Label do

  before do
    stub_get('/labels.xml', 'labels.xml')
  end

  let(:account) { Bugly::Account.new('example.bug.ly', 'abc123') }

  it "fetches all labels" do
    labels = account.labels
    labels.length.should == 1
  end

  it "fetches a specific label" do
    stub_get("/labels/16.xml", "label_16.xml")

    label = account.label(16)
    label.name == 'dependency'
  end

end
