require_relative '../../model/posts'
require_relative '../../model/hashtags'

describe Posts do
  before :each do
    @stub_client = double
    allow(Mysql2::Client).to receive(:new).and_return(@stub_client)
    @post = Posts.new({ id: 1, post_text: 'saya', attachment: 'a.png', user_id: 1, date: '2021-08-17 17:04:54' })
    @post_attach_nil = Posts.new({ id: 1, post_text: 'saya', attachment: nil, user_id: 1,
                                   date: '2021-08-17 17:04:54' })
    @posts = [
      { 'id': 1, 'post_text': 'saya', 'attachment': 'a.png', 'user_id': 1, 'date': '2021-08-17 17:04:54' }
    ]
    @response = { 'id' => 1, 'post_text' => 'saya', 'attachment' => 'a.png', 'user_id' => 1,
                  'date' => '2021-08-17 17:04:54' }
  end

  describe 'initialize' do
    context 'when initialize' do
      it 'return true when valid' do
        expect(@post.valid?).to eq(true)
      end
      it 'return false when not valid' do
        @post = Posts.new({ id: 1, post_text: 'saya' })
        expect(@post.valid?).to eq(false)
      end
    end
  end

  describe 'get_post_by_time' do
    context 'when there are posts within 24 hours' do
      it 'return posts based on time' do
        query = 'select * from posts where date > now() - interval 24 hour'
        expect(@stub_client).to receive(:query).with(query).and_return(@posts)
        get_posts = Posts.get_post_by_time
        expect(get_posts).not_to be_nil
      end
    end
    context 'when there are no posts within 24 hours' do
      it 'return false' do
        query1 = 'select * from posts where date > now() - interval 24 hour'
        expect(@stub_client).to receive(:query).with(query1).and_return(nil)
        get_posts = Posts.get_post_by_time
        expect(get_posts).to eq(false)
      end
    end
  end

  describe 'save' do
    context 'when input is valid' do
      it 'should create posts and return id_post' do
        query = "insert into posts (user_id, post_text, attachment) values (#{@post.user_id}, '#{@post.post_text}', '#{@post.attachment}')"

        expect(@stub_client).to receive(:query).with(query)
        allow(@stub_client).to receive(:last_id).and_return(1)

        expect(@post.save).to eq(@post.id)
      end
    end
    context 'when input is not valid' do
      it 'should return false' do
        @post = Posts.new({ id: 1, text: 'jo' })
        expect(@post.save).to eq(false)
      end
    end
    context 'when attachment is nil' do
      it 'should create posts and return id_post' do
        query = "insert into posts (user_id, post_text, attachment) values (#{@post_attach_nil.user_id}, '#{@post_attach_nil.post_text}', '#{@post_attach_nil.attachment}')"
        query1 = 'SELECT * FROM posts WHERE id = 1'

        expect(@stub_client).to receive(:query).with(query)
        allow(@stub_client).to receive(:last_id).and_return(1)

        expect(@post_attach_nil.save).to eq(@post_attach_nil.id)
      end
    end
  end

  describe 'get_post' do
    context 'when there are posts' do
      it 'return posts' do
        query = 'SELECT * FROM posts WHERE id = 1'
        expect(@stub_client).to receive(:query).with(query).and_return([@response])

        Posts.get_post(1)
      end
    end
  end

  describe 'get_post_by_hashtag' do
    context 'when there are posts based on hashtags' do
      it 'return posts and status 200' do
        query = "select posts.id, posts.user_id, posts.date, posts.post_text, posts.attachment from posts join posts_hashtag on posts.id = posts_hashtag.post_id join hashtags on posts_hashtag.hashtag_id = hashtags.id where hashtags.name = '#hola'"
        hash = {}
        post = []
        @posts.each do |data|
          hash = { id: data['id'], user_id: data['user_id'], date: data['date'],
                   post_text: data['post_text'], attachment: data['attachment'] }
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
    context 'when no posts based on hashtags' do
      it 'return status 404' do
        query = "select posts.id, posts.user_id, posts.date, posts.post_text, posts.attachment from posts join posts_hashtag on posts.id = posts_hashtag.post_id join hashtags on posts_hashtag.hashtag_id = hashtags.id where hashtags.name = '#anak'"
        post = []
        result =
          {
            'status' => 404,
            'message' => 'Not found Post Based on hashtags name'
          }
        expect(@stub_client).to receive(:query).with(query).and_return(post)
        get_posts = Posts.get_post_by_hashtag('#anak')
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
          @post = Posts.new({ id: 1, text: 'saya', attachment: 'a.png', users: nil, hashtag: '[#hola]',
                              date: '2021-08-17 17:04:54' })
          expect(@post.valid?).to eq(false)
        end
        it 'return false when text is nil' do
          @post = Posts.new({ id: 1, text: nil, attachment: 'a.png', users: 1, hashtag: '[#hola]',
                              date: '2021-08-17 17:04:54' })
          expect(@post.valid?).to eq(false)
        end
      end
    end
  end
end
