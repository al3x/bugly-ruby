require 'cgi'

# Wrapper around an a Bugly account. Use this as the root for accessing the
# Bugly API.
class Bugly::Account
  attr_reader :host, :token

  # Connect to a Bugly account. The host is the subdomain for your Bugly
  # account (yourcompany.bug.ly), you can get a token by going to
  # Control Panel -> Users -> you -> API tokens
  def initialize(host, token)
    @host = host
    @token = token

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

    define_method "create_#{resource_singular}".to_sym do |resource_instance|
      response = Bugly.post("/#{resource}.xml",
                            { :body => resource_instance.to_xml })

      resource_class.deserialize(response)
    end
  end

  # issue search
  def issues_matching(query)
    sanitized_query = CGI.escape(query)

    Bugly.
      get("/search.xml?q=#{sanitized_query}").
      parsed_response["issues"].
      map { |p| Bugly::Issue.new(p) }
  end

end
