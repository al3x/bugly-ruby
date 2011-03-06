# Wrapper around an a Bugly account. Use this as the root for accessing the
# Bugly API.
class Bugly::Account
  # Connect to a Bugly account. The host is the subdomain for your Bugly
  # account (yourcompany.bug.ly), you can get a token by going to
  # Control Panel -> Users -> you -> API tokens
  def initialize(host, token)
    Bugly.default_options[:base_uri] = "http://" << host
    Bugly.default_options[:headers] = { 
      "X-BuglyToken" => token
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
end
