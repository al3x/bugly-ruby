class Bugly::Milestone < Bugly::SerializableDash
  property :name
  property :created_at
  property :end_note
  property :end_at
  property :project_id
  property :updated_at
  property :sort_order
  property :id
  property :start_at
  property :description
  property :start_note
  property :created_by

  def milestone_issues_url
    "/milestones/#{id}/issues.xml"
  end

  def issues
    Bugly.
      get(milestone_issues_url).
      parsed_response["issues"].
      map { |p| Bugly::Issue.new(p) }
  end
end
