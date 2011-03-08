require 'spec_helper'

describe Bugly::Category do

  before do
    stub_get('/categories.xml', 'categories.xml')
  end

  let(:account) { Bugly::Account.new('example.bug.ly', 'abc123') }

  
  it "fetches all categories" do
    categories = account.categories
    categories.length.should == 9
  end
  
  it "fetches a specific category" do
    stub_get("/categories/426.xml", "category_426.xml")
    
    category = account.category(426)
    category.name == 'Bug'
  end
  
end
