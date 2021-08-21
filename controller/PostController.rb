require './model/users'
require './model/hashtags'
require './model/posts'

class PostController 
    def get_post_by_hash(params)
        posts = Posts.get_post_by_hashtag(params)
        posts
    end

    def get_post_based_time
        posts = Posts.get_post_by_time
        posts unless posts.nil?
    end
end