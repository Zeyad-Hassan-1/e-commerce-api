class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :bio, :admin
end

# def authorize_admin
#   render json: { error: "Forbidden" }, status: :forbidden unless @current_user&.admin?
# end
