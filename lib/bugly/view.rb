class Bugly::View < Hashie::Dash

  property :name
  property :created_at
  property :updated_at
  property :warn_if_higher
  property :id
  property :warn_if_lower
  property :description
  property :issues

  def view_issues_url
    "/views/#{id}/issues.xml"
  end

  def issues
    Bugly.
      get(view_issues_url).
      parsed_response["issues"].
      map { |p| Bugly::Issue.new(p) }
  end
  
end
