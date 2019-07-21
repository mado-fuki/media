module PostsHelper
  def create_tag_link(post)
    raw post.tag_list.map { |t| link_to "#"+t, tag_path(t) }.join(', ')
  end

  def get_search_word(words)
    unless words.blank?
      "キーワード検索: " + words
    end
  end

  def get_search_tag
    if request.fullpath.include?("/tags/")
      "タグ検索: " + URI.decode(request.fullpath).sub("/tags/", "")
    end
  end
end