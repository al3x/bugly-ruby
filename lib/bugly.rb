require "httparty"
require "hashie"
require "active_model"
require 'active_support/core_ext/string'

class Bugly

  include HTTParty

  # base class
  autoload :Base, "bugly/base"

  # resource classes
  autoload :Account, "bugly/account"
  autoload :Project, "bugly/project"
  autoload :Issue, "bugly/issue"
  autoload :Milestone, "bugly/milestone"
  autoload :View, "bugly/view"
  autoload :Category, "bugly/category"
  autoload :User, "bugly/user"
  autoload :Label, "bugly/label"

  # error class
  autoload :Error, "bugly/error"
end
