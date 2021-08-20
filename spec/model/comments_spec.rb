require_relative '../../model/comments'
require_relative '../../model/hashtags'

describe Comments do
    before :each do
        @stub_client = double
        allow(Mysql2::Client).to receive(:new).and_return(@stub_client)
        @comment = Comments.new({id: 1, post_id: 2, comments_text: "saya", attachment: "a.png", user_id: 1, date: '2021-08-17 17:04:54'})
        @comments_attach_nil = Comments.new({id: 1, post_id: 2, comments_text: "saya", attachment: nil, user_id: 1, date: '2021-08-17 17:04:54'})
        @comments = [
            {'id': 1, 'post_id': 2, 'comments_text': "saya", 'attachment': "a.png", 'user_id': 1, 'date': '2021-08-17 17:04:54'}
        ]
        @response = {'id' => 1, 'post_id' => 2, 'comments_text' => "saya", 'attachment' => "a.png", 'user_id' => 1, 'date' => '2021-08-17 17:04:54'}
    end

    describe 'initialize' do
        context 'when initialize' do
            it 'return true when valid' do
                expect(@comment.valid?).to eq(true)
            end
            it 'return false when not valid' do
                @comment = Comments.new({id: 1, comments_text: "saya"})
                expect(@comment.valid?).to eq(false)
            end
        end
    end 

    describe 'get_comment_by_time' do 
        context 'when there are comments within 24 hours' do 
            it 'return comments based on time' do 
                query = "select * from comments where date > now() - interval 24 hour"
                expect(@stub_client).to receive(:query).with(query).and_return(@comments)
                get_comments = Comments.get_comment_by_time
                expect(get_comments).not_to be_nil
            end
        end
        context 'when there are no comments within 24 hours' do 
            it 'return nil' do 
                query = "select * from comments where date > now() - interval 24 hour"
                expect(@stub_client).to receive(:query).with(query).and_return(nil)
                get_comments = Comments.get_comment_by_time
                expect(get_comments).to eq(false)
            end
        end
    end 

    describe 'get_all_comments' do 
        context 'when there are comments in post' do 
            it 'return comments and status 200' do 
                query = "select * from comments where post_id = 2"
                hash = Hash.new 
                comment = Array.new 
                @comments.each do |data|
                    hash = {:id => data["id"], :post_id => data['post_id'], :user_id => data["user_id"], :date => data["date"], :comments_text => data["post_text"], :attachment => data["attachment"]}
                    comment << hash
                end
                expect(@stub_client).to receive(:query).with(query).and_return(comment)
                get_comments = Comments.get_all_comments(2)
                result = 
                {
                    'status' => 200,
                    'message' => 'Success',
                    'data' => comment
                }
                expect(get_comments).to eq(result)
            end
        end
    end

    describe 'valid?' do
        context 'validation' do 
            it 'return true if valid' do 
                expect(@comment.valid?).to eq(true)
            end
        end 
        context 'when not valid' do
            it 'return false when post_id is nil' do
                @comment = Comments.new({id: 1, post_id: nil, comments_text: "saya", attachment: "a.png", user_id: 1, date: '2021-08-17 17:04:54'})
                expect(@comment.valid?).to eq(false)
            end
            it 'return false when user_id is nil' do
                @comment = Comments.new({id: 1, post_id: 2, comments_text: "saya", attachment: "a.png", users: nil, date: '2021-08-17 17:04:54'})
                expect(@comment.valid?).to eq(false)
            end
            it 'return false when text is nil' do
                @comment = Comments.new({id: 1, post_id: 2, comments_text: nil, attachment: "a.png", user_id: 1, date: '2021-08-17 17:04:54'})
                expect(@comment.valid?).to eq(false)
            end
        end
    end
end