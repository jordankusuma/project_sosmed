require './db/db_connector'

class Hashtags
    attr_accessor :id, :name, :quantity
    
    def initialize(params)
        @id = params[:id]
        @name = params[:name]
        @quantity = params[:quantity]
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