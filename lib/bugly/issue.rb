# Wrapper around an issue.
class Bugly::Issue < Bugly::SerializableDash
  # fields
  property :assigned_to
  property :created_at
  property :milestone_id
  property :body
  property :priority_id
  property :public
  property :title
  property :project_id
  property :updated_at
  property :assigned_at
  property :created_by
  property :category_id
  property :updated_by
  property :assigned_by
  property :status_id
  property :id
  property :priority
  property :status
  
  # substructures
  property :category
  property :project
  property :milestone

  def self.create(issue)
    Bugly.post('/issues.xml', { :body => issue.to_xml })
  end
end
