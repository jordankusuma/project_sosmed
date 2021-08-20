require './db/db_connector'
require './model/users'

class Posts 
    attr_accessor :id, :date, :post_text, :user_id, :attachment, :hashtag

    def initialize(params)
        @id = params[:id]
        @post_text = params[:post_text]
        @attachment = params[:attachment] || nil
        @user_id = params[:user_id]
        @hashtag = params[:hashtag] || nil 
        @date = params[:date]
    end

    #filter hashtag to get all posts 
    def self.get_post_by_hashtag(params)
        client = create_db_client 
        rawData = client.query("select posts.id, posts.user_id, posts.date, posts.post_text, posts.attachment from posts join posts_hashtag on posts.id = posts_hashtag.post_id join hashtags on posts_hashtag.hashtag_id = hashtags.id where hashtags.name = '#{params.downcase}'")
        posts = Array.new 
        hash = Hash.new
        rawData.each do |data|
            hash = {:id => data["id"], :user_id => data["user_id"], :date => data["date"], :post_text => data["post_text"], :attachment => data["attachment"]}
            posts << hash
        end
        if (!posts.empty?)
            {
                'status' => 200,
                'message' => 'Success',
                'data' => posts
            }
        else 
            {
                'status' => 404,
                'message' => 'Not found Post Based on hashtags name'
            }
        end
    end

    #check if value is nil
    def valid?
        return false if @user_id.nil?   
        return false if @post_text.nil? || @post_text.length > 1000
        true
    end
end
