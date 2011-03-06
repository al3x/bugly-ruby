# Wrapper for a Bugly project. Fetch projects using Bugly::Account.
class Bugly::Project < Hashie::Dash
  property :name
  property :assigned_to
  property :created_at
  property :public
  property :email_name
  property :public_heading
  property :updated_at
  property :default_priority_id
  property :created_by
  property :enabled
  property :id
  property :public_interface
  property :max_response_time
  property :default_category_id
  property :description
  property :public_message

  # Fetch all the issues on this project. Returns an array of Bugly::Issue
  # objects.
  def issues
    Bugly.
      get(api_issues_url).
      fetch("issues", []).
      map { |i| Bugly::Issue.new(i) }
  end

  # Fetch all the milestones for this project. Returns an array of
  # Bugly::Milestone objects.
  def milestones
    Bugly.
      get(api_milestones_url).
      fetch("milestones", []).
      map { |m| Bugly::Milestone.new(m) }
  end

  # Fetch all the people linked to this project. Returns an array of
  # Bugly::Person objects.
  #def people
  #  Bugly.
  #    get(api_people_url).
  #    fetch("people", []).
  #    map { |p| Bugly::Person.new(p) }
  #end

end
