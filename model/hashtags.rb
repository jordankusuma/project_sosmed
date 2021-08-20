require './db/db_connector'

class Hashtags
    attr_accessor :id, :name, :quantity
    
    def initialize(params)
        @id = params[:id]
        @name = params[:name]
        @quantity = params[:quantity]
    end

    def self.get_hashtag(params)
        params.downcase.scan(/#(\w+)/).flatten.uniq
    end

    def save_postshashtag(posts_id)
        client = create_db_client 
        rawData = client.query("select * from hashtags where name = '#{@name}'")
        data = rawData.first

        client.query("insert into posts_hashtag values (#{posts_id}, #{data["id"]})")
        true
    end

    def save_commentshashtag(comments_id)
        client = create_db_client 
        rawData = client.query("select * from hashtags where name = '#{@name}'")
        data = rawData.first

        client.query("insert into comments_hashtag values (#{comments_id}, #{data["id"]})")
        true
    end

    def update_hashtag 
        client = create_db_client
        existing = client.query("select * from hashtags where name = '#{@name}'")
    
        data = existing.first
        client.query("update hashtags set quantity = quantity + 1 where name = '#{@name}'") unless data.nil?
    end

    def valid?
        return false if @name.nil? || @quantity.nil?
        true
    end

    def self.reset_quantity
        client = create_db_client 
        client.query("update hashtags set quantity = 0")
        true
    end
end