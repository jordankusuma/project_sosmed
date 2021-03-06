require 'sinatra'
require 'sinatra/namespace'
require './controller/UserController'
require './controller/PostController'
require './controller/CommentController'
require './controller/HashtagController'
require 'sinatra/json'

## Custom Method for Getting Request body
def getBody(req)
  req.body.rewind
  JSON.parse(req.body.read)
end

namespace '/api/v1' do
  before do
    content_type :json
  end

  # Users
  # register
  post '/users/register' do
    body = getBody(request)
    controller = UserController.new
    object = controller.register(body)
    object.to_json
  end
  # End Users

  # posts
  post '/posts/new' do
    @filename = params['files']['filename']
    file = params['files']['tempfile']

    File.open("./uploadsPosts/#{@filename}", 'w') do |f|
      f.write(file.read)
    end

    controller = PostController.new
    object = controller.save(params, @filename)
    object.to_json
  end

  # get post based on hashtag name
  get '/posts/hashtags/{name}' do
    controller = PostController.new
    # name = '#' + params["name"].to_s
    name = params['name'].to_s
    object = controller.get_post_by_hash(name)
    # # object.to_json+"\n"+posts.to_json
    object.to_json
  end
  # end posts

  # comments
  post '/posts/{post_id}/comments/new' do
    @filename = params['files']['filename']
    file = params['files']['tempfile']

    File.open("./uploadsComments/#{@filename}", 'w') do |f|
      f.write(file.read)
    end

    controller = CommentController.new
    object = controller.save(params, @filename)
    object.to_json
  end

  get '/posts/{id}/comments' do
    controller = CommentController.new
    object = controller.get_comments(params['id'].to_i)
    object.to_json
  end
  # end comments

  # hashtags
  # filter trending hashtags
  get '/hashtags' do
    post_controller = PostController.new
    posts = post_controller.get_post_based_time

    comment_controller = CommentController.new
    comments = comment_controller.get_comment_based_time

    controller = HashtagController.new
    object = controller.get_trending_hashtag(posts, comments)
    object.to_json
  end
  # end hashtags
end
