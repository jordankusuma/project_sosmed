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
end