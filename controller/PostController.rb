require './model/users'
require './model/hashtags'
require './model/posts'

class PostController 
    def save(params, filename)
        arr_hashtag = Hashtags.get_hashtag(params['text'])
        posts = Posts.new({"id": 0, "post_text": params['text'], "attachment": filename, "user_id": params['user_id'], "hashtag": arr_hashtag})
        result = posts.save
        if result == false 
            {
                'status' => 500,
                'message' => 'Error',
            }
        else 
            post = Posts.get_post(result) 

            arr_hashtag.each do |data|
                hashtag = Hashtags.new({name: data})
                hashtag.save_hashtags
                hashtag.save_postshashtag(result)
            end
    
            {
                'status' => 200,
                'message' => 'Success',
                'data' => {
                      'id' => result,
                      'user_id' => post.user_id,
                      'post_text' => post.post_text,
                      'date' => post.date,
                      'attachment' => post.attachment,
                      'hashtag' => arr_hashtag
                }
            }
        end
    end
    
    def get_post_by_hash(params)
        posts = Posts.get_post_by_hashtag(params)
        posts
    end

    def get_post_based_time
        posts = Posts.get_post_by_time
        posts unless posts.nil?
    end
end