class BuglyException < StandardError; end

module Bugly::SharedBase
  def plural_resource_name
    ActiveModel::Naming.plural(self).split('_')[1]
  end

  def singular_resource_name
    ActiveModel::Naming.singular(self).split('_')[1]
  end

  def deserialize(response)
    if response.parsed_response.has_key?("errors")
      error_message = response.parsed_response["errors"].collect.flatten.join(", ")
      raise BuglyException, error_message
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


  protected

  def build_attributes
    new_attributes_hash = {}

    keys.each do |k|
      new_attributes_hash[k] = send(k)
    end

    new_attributes_hash
  end

end
