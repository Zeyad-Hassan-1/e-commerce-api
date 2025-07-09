require 'swagger_helper'

RSpec.describe 'API::V1::Users', type: :request do
  path '/api/v1/register' do
    post 'Registers a new user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          email:    { type: :string },
          password: { type: :string },
          bio:      { type: :string }
        },
        required: ['username', 'email', 'password']
      }

      response '201', 'user created' do
        let(:user) { { username: 'test', email: 'test@example.com', password: '12345678', bio: 'test bio' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { username: '' } }
        run_test!
      end
    end
  end
end
