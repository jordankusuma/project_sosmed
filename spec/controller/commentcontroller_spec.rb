require_relative '../../controller/CommentController'

describe CommentController do
    before :each do
        @stub_client = double()
        @controller = CommentController.new
        @comments = Comments.new({"id": 1, "post_id": 1, "comments_text": 'saya #aku', "attachment": 'a.png', "user_id": 1, "hashtag": ["aku"]})
        @arr = [Comments.new({"id": 1, "comments_text": 'saya #aku', "attachment": 'a.png', "user_id": 1, "hashtag": ["aku"]})]
        @response = {'id' => 1, "post_id" => 1, "comments_text" => 'saya #aku', 'attachment' => "a.png", 'user_id' => 1, 'date' => nil, 'hashtag' => ['aku']}
        @response_nofile = {'id' => 1, "post_id" => 1, "comments_text" => 'saya #aku', 'attachment' => nil, 'user_id' => 1, 'date' => nil, 'hashtag' => ['aku']}
        @comments_nofile = Comments.new({"id": 0, "post_id": 1, "comments_text": 'saya #aku', "attachment": nil, "user_id": 1, "hashtag": ["aku"]})
        @hash = ["aku"]
    end

    describe 'get_comments' do 
        context 'when params post_id valid' do 
            it 'return all comments' do 
                params = "aku"
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
                expect(@controller).to receive(:get_comment_based_time).and_return(@arr)

                @controller.get_comment_based_time
            end
        end
        context 'when comments nil' do 
            it 'return false' do 
                allow(Comments).to receive(:get_comment_by_time).and_return(nil)
                expect(@controller).to receive(:get_comment_based_time).and_return(false)

                @controller.get_comment_based_time
            end
        end
    end
end