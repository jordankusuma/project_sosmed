require_relative '../../controller/PostController'

describe PostController do
    before :each do
        @stub_client = double()
        @controller = PostController.new
        @posts = Posts.new({"id": 0, "post_text": 'saya #aku', "attachment": 'a.png', "user_id": 1, "hashtag": ["aku"]})
        @arr = [Posts.new({"id": 0, "post_text": 'saya #aku', "attachment": 'a.png', "user_id": 1, "hashtag": ["aku"]})]
        @response = {'id' => 1, 'post_text' => 'saya #aku', 'attachment' => "a.png", 'user_id' => 1, 'date' => nil, 'hashtag' => ['aku']}
        @response_nofile = {'id' => 1, 'post_text' => 'saya #aku', 'attachment' => nil, 'user_id' => 1, 'date' => nil, 'hashtag' => ['aku']}
        @posts_nofile = Posts.new({"id": 0, "post_text": 'saya #aku', "attachment": nil, "user_id": 1, "hashtag": ["aku"]})
        @hash = ["aku"]
    end

    describe 'get_post_by_hash' do 
        context 'when params hashtag valid' do 
            it 'return post' do 
                params = "aku"
                data = 
                {
                    'status' => 200,
                    'message' => 'Success',
                    'data' => @response
                }

                allow(Posts).to receive(:get_post_by_hashtag).with(params).and_return(data)

                result = @controller.get_post_by_hash(params)
                expect(result).to eq(data)
            end
        end 
        context 'when params hashtag not valid' do 
            it 'return status 404' do 
                params = nil
                data = 
                {
                    'status' => 404,
                    'message' => 'Not found Post Based on hashtags name'
                }
                allow(Posts).to receive(:get_post_by_hashtag).with(params).and_return(data)

                result = @controller.get_post_by_hash(params)
                expect(result).to eq(data)
            end
        end
    end 
    describe 'get_post_based_time' do 
        context 'when posts not nil' do 
            it 'return posts' do 
                allow(Posts).to receive(:get_post_by_time).and_return(@arr)
                expect(@controller).to receive(:get_post_based_time).and_return(@arr)

                @controller.get_post_based_time
            end
        end
    end
end