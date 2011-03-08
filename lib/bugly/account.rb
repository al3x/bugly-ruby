require 'cgi'

# Wrapper around an a Bugly account. Use this as the root for accessing the
# Bugly API.
class Bugly::Account
  
  # Connect to a Bugly account. The host is the subdomain for your Bugly
  # account (yourcompany.bug.ly), you can get a token by going to
  # Control Panel -> Users -> you -> API tokens
  def initialize(host, token)
    Bugly.default_options[:base_uri] = "http://" << host
    Bugly.default_options[:headers] = { 
      "X-BuglyToken" => token,
      "Content-Type" => 'application/xml'
    }
  end

  # Fetch all projects that you have access to for this account. Returns an
  # array of Bugly::Project objects.
  def projects
    Bugly.
      get("/projects.xml").
      parsed_response["projects"].
      map { |p| Bugly::Project.new(p) }
  end
  
  def project(id)
    Bugly::Project.new(
      Bugly.get("/projects/#{id}.xml")["project"]
    )
  end
  
  # milestones
  
  def milestones
    Bugly.
      get("/milestones.xml").
      parsed_response["milestones"].
      map { |p| Bugly::Milestone.new(p) }
  end
  
  def milestone(id)
    Bugly::Milestone.new(
      Bugly.get("/milestones/#{id}.xml")["milestone"]
    )
  end
  
  
  # views
  
  def views
    Bugly.
      get("/views.xml").
      parsed_response["views"].
      map { |p| Bugly::View.new(p) }
  end
  
  def view(id)
    Bugly::View.new(
      Bugly.get("/views/#{id}.xml")["view"]
    )
  end

  # categories

  def categories
    Bugly.
      get("/categories.xml").
      parsed_response["categories"].
      map { |p| Bugly::Category.new(p) }
  end

  def category(id)
    Bugly::Category.new(
      Bugly.get("/categories/#{id}.xml")["category"]
    )
  end

  # users

  def users
    Bugly.
      get("/users.xml").
      parsed_response["users"].
      map { |p| Bugly::User.new(p) }
  end

  def user(id)
    Bugly::User.new(
      Bugly.get("/users/#{id}.xml")["user"]
    )
  end
  
  # issues
  
  def issues
    Bugly.
      get("/issues.xml").
      parsed_response["issues"].
      map { |p| Bugly::Issue.new(p) }
  end
  
  def issue(id)
    Bugly::Issue.new(
      Bugly.get("/issues/#{id}.xml")["issue"]
    )
  end

  
  def issues_matching(query)
    sanitized_query = CGI.escape(query)

    Bugly.
      get("/search.xml?q=#{sanitized_query}").
      parsed_response["issues"].
      map { |p| Bugly::Issue.new(p) }
  end
  
end
