require_relative '../../model/hashtags'

describe Hashtags do
    before :each do
        @stub_client = double
        allow(Mysql2::Client).to receive(:new).and_return(@stub_client)
        @hashtag = Hashtags.new({id: 1, name: "aku", quantity: 0})
        @hashtag_nil = Hashtags.new({id: 1, name: nil, quantity: 0})
        @hashtags = [
            {'id': 1, 'name': "aku", 'quantity': 0}
        ]
        @response = {'id' => 1, 'name' => "aku", 'quantity' => 0}
    end

    describe 'initialize' do
        context 'when initialize' do
            it 'return true when valid' do
                expect(@hashtag.valid?).to eq(true)
            end
            it 'return false when not valid' do
                @hashtag = Hashtags.new({id: 1, name: "aku"})
                expect(@hashtag.valid?).to eq(false)
            end
        end 
    end

    describe 'save_hashtags' do 
        context 'when hashtag is new' do
            it 'create new hashtag' do
                query = "select * from hashtags where name = '#{@hashtag.name}'"
                query1 = "insert into hashtags (name, quantity) values ('#{@hashtag.name}', #{@hashtag.quantity})"
            
                expect(@stub_client).to receive(:query).with(query).and_return([@response])               
                expect(@stub_client).to receive(:query).with(query).and_return([@response])               
                expect(@stub_client).to receive(:query).with(query1)

                expect(@hashtag.save_hashtags).to eq(true)
            end
        end
        context 'when hashtag is not new' do
            it 'return true' do
                query = "select * from hashtags where name = 'aku'"
                expect(@stub_client).to receive(:query).with(query).and_return([@response])               
                expect(@stub_client).to receive(:query).with(query).and_return([@response])               
                expect(@hashtag.save_hashtags).to eq(true)
            end
        end
    end

    describe 'save_postshashtag' do 
        context 'when params valid' do
            it 'save into posts_hashtag' do
                query1 = "select * from hashtags where name = 'aku'"
                query = "insert into posts_hashtag values (2, 1)"
                
                expect(@stub_client).to receive(:query).with(query)               
                expect(@stub_client).to receive(:query).with(query1).and_return([@response])   
                
                expect(@hashtag.save_postshashtag(2)).to eq(true)
            end
        end
    end

    describe 'save_commentshashtag' do 
        context 'when params valid' do
            it 'save into comments_hashtag' do
                query1 = "select * from hashtags where name = 'aku'"
                query = "insert into comments_hashtag values (2, 1)"
                
                expect(@stub_client).to receive(:query).with(query)               
                expect(@stub_client).to receive(:query).with(query1).and_return([@response])   
                
                expect(@hashtag.save_commentshashtag(2)).to eq(true)
            end
        end
    end

    describe 'update_hashtag' do 
        context 'when hashtag available' do
            it 'save into comments_hashtag' do
                query = "select * from hashtags where name = '#{@hashtag.name}'"
                query1 = "update hashtags set quantity = quantity + 1 where name = '#{@hashtag.name}'"
                expect(@stub_client).to receive(:query).with(query).and_return([@response])               
                expect(@stub_client).to receive(:query).with(query1)

                @hashtag.update_hashtag
            end
        end
    end

    describe 'get_hashtag' do 
        context 'when params text available' do
            it 'return array of hashtag' do
                hash = ["aku"]
                expect(Hashtags.get_hashtag("#aku")).to eq(hash)
            end
        end
    end

    describe 'valid?' do 
        context 'validation' do 
            it 'return true if valid' do 
                expect(@hashtag.valid?).to eq(true)
            end
        end 
        context 'when not valid' do
            it 'return false when name is nil' do
                @hashtag = Hashtags.new({id: 1, name: nil, quantity: 0})
                expect(@hashtag.valid?).to eq(false)
            end
            it 'return false when quantity is nil' do
                @hashtag = Hashtags.new({id: 1, name: 'aku', quantity: nil})
                expect(@hashtag.valid?).to eq(false)
            end
        end
    end

    describe 'reset_quantity' do 
        it 'reset all hashtag quantity' do
            query = "update hashtags set quantity = 0"
            expect(@stub_client).to receive(:query).with(query)
            expect(Hashtags.reset_quantity).to eq(true)
        end
    end

    describe 'get_trending_hashtag' do 
        context 'when there are posts on 24 hours' do 
            it 'return hashtags and status 200' do 
                query = "select * from hashtags order by quantity desc limit 5"
                hash = Hash.new 
                hashtag = Array.new 
                @hashtags.each do |data|
                    hash = {:id => data["id"], :name => data["name"], :quantity => data["quantity"]}
                    hashtag << hash
                end
                expect(@stub_client).to receive(:query).with(query).and_return(hashtag)
                get_hashtags = Hashtags.get_trending_hashtag
                result = 
                {
                    'status' => 200,
                    'message' => 'Success',
                    'data' => hashtag
                }
                expect(get_hashtags).to eq(result)
            end
        end
        context 'when no posts on 24 hours' do 
            it 'return status 404' do 
                query = "select * from hashtags order by quantity desc limit 5"
                hashtag = Array.new
                result = 
                {
                    'status' => 404,
                    'message' => 'Not found post/comments in 24 hours'
                }
                expect(@stub_client).to receive(:query).with(query).and_return(hashtag)
                get_hashtags = Hashtags.get_trending_hashtag
                expect(get_hashtags).to eq(result)
            end
        end
    end
end