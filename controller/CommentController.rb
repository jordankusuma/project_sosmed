require './model/users'
require './model/hashtags'
require './model/posts'
require './model/comments'

class CommentController 
    def save(params, filename)
        arr_hashtag = Hashtags.get_hashtag(params['text'])
        comments = Comments.new({"id": 0, "post": params['post_id'], "text": params['text'], "attachment": filename, "users": params['user_id'], "hashtag": arr_hashtag})
        result = comments.save

        if result == false 
            {
                'status' => 500,
                'message' => 'Error',
            }
        else 
            comment = Comments.get_comment(result) 

            arr_hashtag.each do |data|
                hashtag = Hashtags.new({name: data})
                hashtag.save_hashtags
                hashtag.save_commentshashtag(result)
            end

            {
                'status' => 200,
                'message' => 'Success',
                'data' => {
                    'id' => result,
                    'post_id' => comment.post_id,
                    'user_id' => comment.user_id,
                    'comments_text' => comment.comments_text,
                    'date' => comment.date,
                    'attachment' => comment.attachment,
                    'hashtag' => arr_hashtag
                }
            }
        end
    end
    
    def get_comments(params)
        comment = Comments.get_all_comments(params) 
        comment unless comment.nil?
    end

    def get_comment_based_time
        comments = Comments.get_comment_by_time
        comments unless comments.nil?
    end
end