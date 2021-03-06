require_relative '../../controller/HashtagController'

describe HashtagController do
  before :each do
    @stub_client = double
    @controller = HashtagController.new
    @comments = Comments.new({ "id": 1, "post_id": 1, "comments_text": 'saya #aku', "attachment": 'a.png',
                               "user_id": 1, "hashtag": ['aku'] })
    @posts = Posts.new({ "id": 0, "post_text": 'saya #aku', "attachment": 'a.png', "user_id": 1, "hashtag": ['aku'] })
    @posts_arr = [Posts.new({ "id": 0, "post_text": 'saya #aku', "attachment": 'a.png', "user_id": 1,
                              "hashtag": ['aku'] })]
    @comments_arr = [Comments.new({ "id": 1, "post_id": 1, "comments_text": 'saya #aku', "attachment": 'a.png',
                                    "user_id": 1, "hashtag": ['aku'] })]
    @text = ['saya #aku']
    @hash = ['aku']
    @response = { 'id' => 1, 'name' => 'aku', 'quantity' => '0' }
  end

  describe 'get_trending_hashtag' do
    context 'when text available' do
      it 'return trending hashtags and status 200' do
        allow(Hashtags).to receive(:reset_quantity)

        data =
          {
            'status' => 200,
            'message' => 'Success',
            'data' => @response
          }

        allow(Hashtags).to receive(:get_trending_hashtag).and_return(data)

        expected_result = @controller.get_trending_hashtag(@posts_arr, @comments_arr)
        expect(expected_result).to eq(data)
      end
    end
  end

  describe 'update_quantity' do
    context 'when text is valid' do
      it 'update hashtags' do
        allow(Hashtags).to receive(:get_hashtag).with(@text).and_return(@hash)

        allow(Hashtags).to receive(:new).and_return(@stub_client)
        allow(@stub_client).to receive(:update_hashtag)
      end
    end
  end

  describe 'get_post' do
    context 'when params not nil' do
      it 'return data' do
        expect(@controller).to receive(:get_post).with(@posts).and_return(@text)

        expected_result = @controller.get_post(@posts)
        expect(expected_result).to eq(@text)
      end
    end
    context 'when params is nil' do
      it 'return false' do
        expect(@controller).to receive(:get_post).with([]).and_return(false)

        expected_result = @controller.get_post([])
        expect(expected_result).to eq(false)
      end
    end
  end

  describe 'get_comment' do
    context 'when params not nil' do
      it 'return data' do
        expect(@controller).to receive(:get_comment).with(@comments).and_return(@text)

        expected_result = @controller.get_comment(@comments)
        expect(expected_result).to eq(@text)
      end
    end
    context 'when params is nil' do
      it 'return false' do
        expect(@controller).to receive(:get_comment).with(nil).and_return(false)

        expected_result = @controller.get_comment(nil)
        expect(expected_result).to eq(false)
      end
    end
  end
end
