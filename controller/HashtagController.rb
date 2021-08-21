require './model/hashtags'

class HashtagController 
    def get_trending_hashtag(posts, comments)
        posts_text = get_post(posts)
        comments_text = get_comment(comments)

        if (posts_text != false && comments_text != false)
            Hashtags.reset_quantity
            #get post hashtag and update quantity
            update_quantity(posts_text)
            update_quantity(comments_text)

            hashtags = Hashtags.get_trending_hashtag
            hashtags
        else 
            {
                'status' => 404,
                'message' => 'Not found post/comments in 24 hours',
            }
        end
    end
    
    def get_post(params)
        if (params != nil)
            data = Array.new 
            params.each do |param|
                data.push(param.post_text)
            end
            data
        else 
            false
        end
    end

    def get_comment(params)
        if (params != nil)
            data = Array.new 
            params.each do |param|
                data.push(param.comments_text)
            end
            data
        else 
            false
        end
    end

    def update_quantity(text) 
        text.each do |params|
            arr_hashtag = Hashtags.get_hashtag(params)
            arr_hashtag.each do |data|
                hashtag = Hashtags.new({name: data})
                hashtag.update_hashtag
            end
        end
    end
end