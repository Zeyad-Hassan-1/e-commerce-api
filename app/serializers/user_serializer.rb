class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :bio, :admin, :email, :confirmation_token, :reset_password_token, :email_confirmed
end
# This serializer is used to format the user data when it is serialized to JSON.
