class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :bio, :admin
end
# This serializer is used to format the user data when it is serialized to JSON.
