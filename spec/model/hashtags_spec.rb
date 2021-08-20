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
end