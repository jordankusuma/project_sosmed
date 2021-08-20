require_relative '../db/db_connector'

class Users
  attr_accessor :id, :username, :email, :bio

  def initialize(params)
    @id = params[:id]
    @username = params[:username]
    @email = params[:email]
    @bio = params[:bio]
  end

  #create new account
  def register
    client = create_db_client 
    return false unless valid?
    client.query("INSERT INTO users VALUES (0, '#{@username}', '#{@email}', '#{@bio}')")
    
    id_new = client.last_id()
    id_new
  end

  # check if value is nil
  def valid?
    if @bio.nil? || @email.nil? || @username.nil? || !@email.match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
      return false
    end

    true
  end
end
