ThinkingSphinx::Index.define :task, :with => :active_record do
  # fields
  indexes title, :sortable => true
  indexes description

  # attributes
  has user_id, created_at, updated_at
end
