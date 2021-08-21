require './model/users'
require './model/hashtags'
require './model/posts'
require './model/comments'

class CommentController 
    def get_comments(params)
        comment = Comments.get_all_comments(params) 
        comment unless comment.nil?
    end

    
end