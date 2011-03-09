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

  resources = %w(projects milestones views categories users labels issues)

  resources.each do |resource|
    resource_class = "Bugly::#{resource.classify}".constantize
    resource_singular = resource.singularize

    define_method resource.to_sym do
      Bugly.
        get("/#{resource}.xml").
        parsed_response[resource].
        map { |p| resource_class.new(p) }
    end

    define_method resource_singular.to_sym do |id|
      resource_class.new(
        Bugly.get("/#{resource}/#{id}.xml")[resource_singular]
      )
    end
  end

  # issues

  def issues_matching(query)
    sanitized_query = CGI.escape(query)

    Bugly.
      get("/search.xml?q=#{sanitized_query}").
      parsed_response["issues"].
      map { |p| Bugly::Issue.new(p) }
  end
  
end
