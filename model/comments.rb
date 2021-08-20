require './db/db_connector'
require './model/users'
require 'date'

class Comments 
    attr_accessor :id, :post_id, :date, :comments_text, :user_id, :attachment, :hashtag

    def initialize(params)
        @id = params[:id]
        @post_id = params[:post_id]
        @comments_text = params[:comments_text]
        @attachment = params[:attachment] || nil
        @user_id = params[:user_id]
        @hashtag = params[:hashtags] || nil
        @date = params[:date]
    end

    #get posts interval 24 hours
    def self.get_comment_by_time
        client = create_db_client 
        rawData = client.query("select * from comments where date > now() - interval 24 hour")
        if (rawData.nil?)
            false
        else    
            comments = Array.new 
            rawData.each do |data|
                comment = Comments.new({id: data["id"], post_id: data["post_id"], user_id: data["user_id"], date: data["date"], comments_text: data["comments_text"], attachment: data["attachment"]})
                comments.push(comment)
            end
            comments
        end
    end

    #check if value is nil
    def valid?
        return false if @post_id.nil?
        return false if @user_id.nil?   
        return false if @comments_text.nil? || @comments_text.length > 1000
        true
    end
end
