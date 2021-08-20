require_relative '../../model/posts'
require_relative '../../model/hashtags'

describe Posts do
    before :each do
        @stub_client = double
        allow(Mysql2::Client).to receive(:new).and_return(@stub_client)
        @post = Posts.new({id: 1, post_text: "saya", attachment: "a.png", user_id: 1, date: '2021-08-17 17:04:54'})
        @post_attach_nil = Posts.new({id: 1, post_text: "saya", attachment: nil, user_id: 1, date: '2021-08-17 17:04:54'})
        @posts = [
            {'id': 1, 'post_text': "saya", 'attachment': "a.png", 'user_id': 1, 'date': '2021-08-17 17:04:54'}
        ]
        @response = {'id' => 1, 'post_text' => "saya", 'attachment' => "a.png", 'user_id' => 1, 'date' => '2021-08-17 17:04:54'}
    end

    describe 'initialize' do
        context 'when initialize' do
            it 'return true when valid' do
                expect(@post.valid?).to eq(true)
            end
            it 'return false when not valid' do
                @post = Posts.new({id: 1, post_text: "saya"})
                expect(@post.valid?).to eq(false)
            end
        end 
    end

    describe 'get_post_by_hashtag' do 
        context 'when there are posts based on hashtags' do 
            it 'return posts and status 200' do 
                query = "select posts.id, posts.user_id, posts.date, posts.post_text, posts.attachment from posts join posts_hashtag on posts.id = posts_hashtag.post_id join hashtags on posts_hashtag.hashtag_id = hashtags.id where hashtags.name = '#hola'"
                hash = Hash.new 
                post = Array.new 
                @posts.each do |data|
                    hash = {:id => data["id"], :user_id => data["user_id"], :date => data["date"], :post_text => data["post_text"], :attachment => data["attachment"]}
                    post << hash
                end
                expect(@stub_client).to receive(:query).with(query).and_return(post)
                get_posts = Posts.get_post_by_hashtag('#hola')
                result = 
                {
                    'status' => 200,
                    'message' => 'Success',
                    'data' => post
                }
                expect(get_posts).to eq(result)
            end
        end
    end

    describe 'valid?' do
        context 'validation' do 
            it 'return true if valid' do 
                expect(@post.valid?).to eq(true)
            end
            context 'when not valid' do
                it 'return false when user_id is nil' do
                    @post = Posts.new({id: 1, text: "saya", attachment: "a.png", users: nil, hashtag: "[#hola]", date: '2021-08-17 17:04:54'})
                    expect(@post.valid?).to eq(false)
                end
                it 'return false when text is nil' do
                    @post = Posts.new({id: 1, text: nil, attachment: "a.png", users: 1, hashtag: "[#hola]", date: '2021-08-17 17:04:54'})
                    expect(@post.valid?).to eq(false)
                end
            end
        end 
    end
end 