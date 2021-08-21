require './model/users'

class UserController
    #create account for user
    def register(params)
        users = Users.new({"id": 0, "username": params['username'], "email": params['email'], "bio": params['bio']})
        result = users.register
        if (result != false)
            {
                'status' => 200,
                'message' => 'Success',
                'data' => {
                    'id' => result,
                    'username' => params['username'],
                    'email' => params['email'],
                    'bio' => params['bio']
                }
            }
        else 
            {
                'status' => 500,
                'message' => 'Users not valid',
            }
        end
    end
end