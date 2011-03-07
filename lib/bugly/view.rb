class Bugly::View < Hashie::Dash
  property :name
  property :created_at
  property :updated_at
  property :warn_if_higher
  property :id
  property :warn_if_lower
  property :description
end
