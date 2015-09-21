module ApplicationHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true,
        space_after_headers: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def most_used_tags
    ActsAsTaggableOn::Tag.most_used(20)
  end

  def generate_tasks_by_query(query)
    comments = Comment.search query
    tags = Tag.search query
    query_tasks = Task.search query
        
    Task.tagged_with(query).each do |task|
      query_tasks << task
    end

    comments.each do |comment|
      task = Task.find(comment.task_id)
      if task
        query_tasks << task
      end 
    end 
    query_tasks
  end
end
