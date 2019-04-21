module PostsHelper
  def create_tag_link(post)
    raw post.tag_list.map { |t| link_to "#"+t, tag_path(t) }.join(', ')
  end
end