require_relative '../../controller/CommentController'

describe CommentController do
  before :each do
    @stub_client = double
    @controller = CommentController.new
    @comments = Comments.new({ "id": 1, "post_id": 1, "comments_text": 'saya #aku', "attachment": 'a.png',
                               "user_id": 1, "hashtag": ['aku'] })
    @arr = [Comments.new({ "id": 1, "post_id": 1, "comments_text": 'saya #aku', "attachment": 'a.png', "user_id": 1,
                           "hashtag": ['aku'] })]
    @response = { 'id' => 1, 'post_id' => 1, 'comments_text' => 'saya #aku', 'attachment' => 'a.png',
                  'user_id' => 1, 'date' => nil, 'hashtag' => ['aku'] }
    @response_nofile = { 'id' => 1, 'post_id' => 1, 'comments_text' => 'saya #aku', 'attachment' => nil,
                         'user_id' => 1, 'date' => nil, 'hashtag' => ['aku'] }
    @comments_nofile = Comments.new({ "id": 0, "post_id": 1, "comments_text": 'saya #aku', "attachment": nil,
                                      "user_id": 1, "hashtag": ['aku'] })
    @hash = ['aku']
  end

  describe 'get_comments' do
    context 'when params post_id valid' do
      it 'return all comments' do
        params = 'aku'
        data =
          {
            'status' => 200,
            'message' => 'Success',
            'data' => @response
          }

        allow(Comments).to receive(:get_all_comments).with(params).and_return(data)

        result = @controller.get_comments(params)
        expect(result).to eq(data)
      end
    end
    context 'when params post_id not valid' do
      it 'return false' do
        params = nil
        data =
          {
            'status' => 404,
            'message' => 'Not found comments based on post_id'
          }
        allow(Comments).to receive(:get_all_comments).with(params).and_return(data)

        result = @controller.get_comments(params)
        expect(result).to eq(data)
      end
    end
  end
  describe 'get_comment_based_time' do
    context 'when comments not nil' do
      it 'return comments' do
        allow(Comments).to receive(:get_comment_by_time).and_return(@arr)
        result = @controller.get_comment_based_time 
        expect(result).to eq(@arr)
      end
    end
    context 'when comments nil' do
      it 'return false' do
        allow(Comments).to receive(:get_comment_by_time).and_return(false)
        result = @controller.get_comment_based_time 
        expect(result).to eq(false)
      end
    end
  end
  describe 'save' do
    context 'when params is valid' do
      it 'create posts and return 200' do
        params =
          {
            'files' => 'a.png',
            'text' => 'saya #aku',
            'user_id' => 1,
            'post_id' => 1
          }
        data =
          {
            'status' => 200,
            'message' => 'Success',
            'data' => @response
          }
        allow(Hashtags).to receive(:get_hashtag).with(params['text']).and_return(@hash)

        allow(Comments).to receive(:new).and_return(@stub_client)
        allow(@stub_client).to receive(:save).and_return(1)

        allow(Comments).to receive(:get_comment).with(1).and_return(@comments)

        stub_hashtag = double
        allow(Hashtags).to receive(:new).and_return(stub_hashtag)
        allow(stub_hashtag).to receive(:save_hashtags)
        allow(stub_hashtag).to receive(:save_commentshashtag).with(1)

        expected_result = @controller.save(params, 'a.png')
        expect(expected_result).to eq(data)
      end
    end
    context 'when params is not valid' do
      it 'return status 500' do
        params =
          {
            'files' => 'a.png',
            'user_id' => 1,
            'post_id' => 1
          }
        data =
          {
            'status' => 500,
            'message' => 'Error'
          }
        allow(Hashtags).to receive(:get_hashtag).with(params['text']).and_return(@hash)

        allow(Comments).to receive(:new).and_return(@stub_client)
        allow(@stub_client).to receive(:save).and_return(false)

        expected_result = @controller.save(params, 'a.png')
        expect(expected_result).to eq(data)
      end
    end
    context 'when attachment is nil' do
      it 'return status 200' do
        params =
          {
            'files' => nil,
            'text' => 'saya #aku',
            'user_id' => 1,
            'post_id' => 1
          }
        data =
          {
            'status' => 200,
            'message' => 'Success',
            'data' => @response_nofile
          }
        allow(Hashtags).to receive(:get_hashtag).with(params['text']).and_return(@hash)

        allow(Comments).to receive(:new).and_return(@stub_client)
        allow(@stub_client).to receive(:save).and_return(1)

        allow(Comments).to receive(:get_comment).with(1).and_return(@comments_nofile)

        stub_hashtag = double
        allow(Hashtags).to receive(:new).and_return(stub_hashtag)
        allow(stub_hashtag).to receive(:save_hashtags)
        allow(stub_hashtag).to receive(:save_commentshashtag).with(1)

        expected_result = @controller.save(params, nil)
        expect(expected_result).to eq(data)
      end
    end
  end
end
