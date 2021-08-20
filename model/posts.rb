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

    #check if value is nil
    def valid?
        return false if @user_id.nil?   
        return false if @post_text.nil? || @post_text.length > 1000
        true
    end
end
