require_relative '../../model/users'

describe Users do
    before :each do
        @stub_client = double()
        allow(Mysql2::Client).to receive(:new).and_return(@stub_client)
        @user = Users.new({id: 0, username: "jo", email: "a@gmail.com", bio: "saya"})
        @response = { 'id' => 0, 'username' => 'jo', 'email' => 'a@gmail.com', 'bio' => 'saya' }
    end
    describe 'initialize' do
        context 'when initialize' do
            it 'return true when valid' do
                expect(@user.valid?).to eq(true)
            end
            it 'return false when not valid' do
                @user = Users.new({id: 0, username: "jo"})
                expect(@user.valid?).to eq(false)
            end
        end 
    end

    describe 'valid?' do
        context 'validation' do 
            it 'return true if valid' do 
                expect(@user.valid?).to eq(true)
            end
        end
    end
end 