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
end