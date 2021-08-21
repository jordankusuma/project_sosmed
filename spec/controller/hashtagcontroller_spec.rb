require_relative '../../controller/HashtagController'

describe CommentController do
    before :each do
        @stub_client = double()
        @controller = HashtagController.new
        @comments = Comments.new({"id": 1, "post_id": 1, "comments_text": 'saya #aku', "attachment": 'a.png', "user_id": 1, "hashtag": ["aku"]})
        @posts = Posts.new({"id": 0, "post_text": 'saya #aku', "attachment": 'a.png', "user_id": 1, "hashtag": ["aku"]})
        @posts_arr = [Posts.new({"id": 0, "post_text": 'saya #aku', "attachment": 'a.png', "user_id": 1, "hashtag": ["aku"]})]
        @comments_arr = [Comments.new({"id": 1, "post_id": 1, "comments_text": 'saya #aku', "attachment": 'a.png', "user_id": 1, "hashtag": ["aku"]})]
        @text = ['saya #aku']
        @hash = ["aku"]
        @response = {'id' => 1, "name" => "aku", "quantity" => '0'}
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
end 