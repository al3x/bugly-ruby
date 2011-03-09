module Bugly::SharedBase
  def plural_resource_name
    ActiveModel::Naming.plural(self).split('_')[1]
  end

  def singular_resource_name
    ActiveModel::Naming.singular(self).split('_')[1]
  end

  def deserialize(response)
    if response =~ /<errors>/
      Bugly::Error.new(response["errors"])
    else
      new(response[singular_resource_name])
    end
  end
end


class Bugly::Base < Hashie::Dash

  include ActiveModel::Serializers::Xml
  extend ActiveModel::Naming

  # we intentionally want these shared methods available to both
  # the class and instances
  include Bugly::SharedBase
  extend Bugly::SharedBase

  # class methods

  def self.create(resource)
    response = Bugly.post("/#{plural_resource_name}.xml",
                          { :body => resource.to_xml })

    deserialize response
  end

  # instance methods

  def attributes
    @attributes ||= build_attributes
  end

  def update
    Bugly.put("/#{plural_resource_name}/#{id}.xml",
              { :body => self.to_xml })
  end

  def delete
    Bugly.delete("/#{plural_resource_name}/#{id}.xml")
  end


  private

  def build_attributes
    new_attributes_hash = {}

    keys.each do |k|
      new_attributes_hash[k] = send(k)
    end

    new_attributes_hash
  end

end
