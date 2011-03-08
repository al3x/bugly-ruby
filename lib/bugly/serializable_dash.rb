class Bugly::SerializableDash < Hashie::Dash
  include ActiveModel::Serializers::Xml

  def attributes
    new_attributes_hash = {}

    keys.each do |k|
      new_attributes_hash[k] = send(k)
    end

    @attributes ||= new_attributes_hash
  end

  def self.model_name
    ActiveModel::Name.new(self)
  end
end
