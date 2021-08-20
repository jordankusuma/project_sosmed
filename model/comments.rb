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

    #add posts 
    def save
        client = create_db_client 
        return false unless valid?
        client.query("insert into comments (post_id, user_id, comments_text, attachment) values (#{@post_id}, #{@user_id}, '#{@comments_text}', '#{@attachment}')")

        id_new = client.last_id()
        id_new
    end 

    def self.get_comment(id_new)
        client = create_db_client
        rawData = client.query("SELECT * FROM comments WHERE id = #{id_new}")
        data = rawData.first
        comment = Comments.new({id: id_new, post_id: data['post_id'], comments_text: data['comments_text'], attachment: data['attachment'], user_id: data['user_id'], date: data['date']})
        comment
    end

    def self.get_all_comments(posts)
        client = create_db_client 
        rawData = client.query("select * from comments where post_id = #{posts}")
        comments = Array.new 
        hash = Hash.new
        rawData.each do |data|
            hash = {:id => data['id'], :post_id => data['post_id'], :user_id => data['user_id'], :date => data['date'], :comments_text => data['comments_text'], :attachment => data["attachment"]}
            comments << hash
        end
        if (!comments.empty?)
            {
                'status' => 200,
                'message' => 'Success',
                'data' => comments
            }
        else 
            {
                'status' => 404,
                'message' => 'Not found comments based on post_id',
            }
        end
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
