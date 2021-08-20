require 'sinatra'
require 'sinatra/namespace'
require './controller/UserController'
require './controller/PostController'
require './controller/CommentController'
require './controller/HashtagController'
require 'sinatra/json'

## Custom Method for Getting Request body
def getBody (req)
  req.body.rewind
  return JSON.parse(req.body.read)
end

namespace '/api/v1' do
  before do
    content_type :json
  end

  #Users
  #register
  post '/users/register' do
    body = getBody(request)
    controller = UserController.new
		object = controller.register(body)
    object.to_json
  end
  #End Users

  
end