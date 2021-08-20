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