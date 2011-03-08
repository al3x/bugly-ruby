require "httparty"
require "hashie"
require "active_model"

class Bugly
  include HTTParty

  autoload :Account, "bugly/account"
  autoload :Project, "bugly/project"
  autoload :Issue, "bugly/issue"
  autoload :Milestone, "bugly/milestone"
  autoload :View, "bugly/view"
  autoload :Category, "bugly/category"
  autoload :User, "bugly/user"
  autoload :Label, "bugly/label"
  autoload :SerializableDash, "bugly/serializable_dash"
end
