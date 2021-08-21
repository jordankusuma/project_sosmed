require './model/hashtags'

class HashtagController 
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