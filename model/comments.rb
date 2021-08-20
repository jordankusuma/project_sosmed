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

    #check if value is nil
    def valid?
        return false if @post_id.nil?
        return false if @user_id.nil?   
        return false if @comments_text.nil? || @comments_text.length > 1000
        true
    end
end
