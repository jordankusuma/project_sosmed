require './db/db_connector'

class Hashtags
    attr_accessor :id, :name, :quantity
    
    def initialize(params)
        @id = params[:id]
        @name = params[:name]
        @quantity = params[:quantity]
    end

    def save_hashtags
        client = create_db_client 
        existing = client.query("select * from hashtags where name = '#{@name}'")
    
        data = existing.first
        client.query("insert into hashtags (name, quantity) values ('#{@name}', 0)") if data.nil?

        response = client.query("select * from hashtags where name = '#{@name}'")
        hash = response.first 

        hashtag = Hashtags.new({id: hash["id"], name: hash["name"], quantity: hash["quantity"]})
        return false unless hashtag.valid?
        true
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

    def self.get_trending_hashtag
        client = create_db_client 
        rawData = client.query("select * from hashtags order by quantity desc limit 5")
        hashtags = Array.new 
        hash = Hash.new
        rawData.each do |data|
            hash = {:id => data['id'], :name => data['name'], :quantity => data['quantity']}
            hashtags << hash
        end
        if (!hashtags.empty?)
            {
                'status' => 200,
                'message' => 'Success',
                'data' => hashtags
            }
        else 
            {
                'status' => 404,
                'message' => 'Not found post/comments in 24 hours',
            }
        end
    end
end