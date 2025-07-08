class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :colors, :sizes, :images, :categories
end
