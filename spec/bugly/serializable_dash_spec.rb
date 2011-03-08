require 'spec_helper'
require 'rexml/document'

# simple test class
class Person < Bugly::SerializableDash
  property :name
  property :age
end

describe Bugly::SerializableDash do

  it "can be serialized to XML" do
    bob = Person.new
    bob.name = "Bob Smith"
    bob.age = 66

    bob.attributes.should have_key("name")
    bob.attributes.should have_key("age")
    bob.attributes.keys.should have(2).items

    bob.to_xml.should_not be_nil

    # ensure that the generated XML actually parses without exception
    lambda { REXML::Document.new(bob.to_xml) }.should_not raise_error
  end
  
end
