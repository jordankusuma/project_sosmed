require './model/users'
require './model/hashtags'
require './model/posts'
require './model/comments'

class CommentController 
    def get_comments(params)
        comment = Comments.get_all_comments(params) 
        comment unless comment.nil?
    end

    def get_comment_based_time
        comments = Comments.get_comment_by_time
        comments unless comments.nil?
    end
end