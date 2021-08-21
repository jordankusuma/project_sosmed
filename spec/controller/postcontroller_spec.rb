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

                result = Posts.get_post_by_hashtag(params)
                expect(result).to eq(data)

                @controller.get_post_by_hash(params)
            end
        end 

    end 

end