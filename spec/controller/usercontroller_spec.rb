require_relative '../../controller/UserController'

describe UserController do
    before :each do
        @stub_client = double()
        @controller = UserController.new
        @users = Users.new({"id": 0, "username": 'jo', "email": 'a@gmail.com', "bio": 'saya'})
    end

    describe 'register' do 
        context 'when register return id' do
            it 'shows status 200 with data' do
                params = 
                {
                    "username": "jo",
                    "email": "a@gmail.com",
                    "bio": "saya"
                }
                
                response = 
                {
                    'status' => 200,
                    'message' => 'Success',
                    'data' => {
                        'id' => 1,
                        'username' => params['username'],
                        'email' => params['email'],
                        'bio' => params['bio']
                    }
                }   

                allow(Users).to receive(:new).and_return(@stub_client)
                expect(@stub_client).to receive(:register).and_return(1)

                result = @controller.register(params)
                expect(result).to eq(response)
            end 
        end 
    end
end