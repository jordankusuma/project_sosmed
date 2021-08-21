require './model/hashtags'

class HashtagController 
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