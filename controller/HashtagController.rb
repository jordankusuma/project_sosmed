require './model/hashtags'

class HashtagController
  def get_trending_hashtag(posts, comments)
    posts_text = get_post(posts)
    comments_text = get_comment(comments)
    
    Hashtags.reset_quantity
    # get post hashtag and update quantity
    update_quantity(posts_text)
    update_quantity(comments_text)

    Hashtags.get_trending_hashtag
  end

  def get_post(params)
    data = []
    params.each do |param|
      data.push(param.post_text)
    end
    data
  end

  def get_comment(params)
    data = []
    params.each do |param|
      data.push(param.comments_text)
    end
    data
  end

  def update_quantity(text)
    text.each do |params|
      arr_hashtag = Hashtags.get_hashtag(params)
      arr_hashtag.each do |data|
        hashtag = Hashtags.new({ name: data })
        hashtag.update_hashtag
      end
    end
  end
end
