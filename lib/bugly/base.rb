class Bugly::Base < Hashie::Dash

  include ActiveModel::Serializers::Xml
  extend ActiveModel::Naming

  # class methods

  def self.create(resource)
    Bugly.post("/#{resource_name_for_url}.xml",
               { :body => resource.to_xml })
  end


  def self.resource_name_for_url
    ActiveModel::Naming.plural(self).split('_')[1]
  end

  # instance methods

  def attributes
    @attributes ||= build_attributes
  end

  def update(resource)
    Bugly.put("/#{resource_name_for_url}/#{id}.xml",
              { :body => resource.to_xml })
  end

  def self.delete(resource)
    Bugly.delete("/#{resource_name_for_url}.xml",
                 { :body => resource.to_xml })
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
