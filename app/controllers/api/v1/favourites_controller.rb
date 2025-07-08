class Api::V1::FavouritesController < ApplicationController
  before_action :authorized

  def index
    favourites = current_user.favourite_products
    render json: favourites, each_serializer: ProductSerializer
  end

  def create
    product = Product.find_by(id: params[:product_id])
    return render json: { error: "Product not found" }, status: :not_found unless product

    if current_user.favourites.exists?(product_id: product.id)
      return render json: { message: "Already favourite" }, status: :unprocessable_entity
    end

    fav = current_user.favourites.build(product: product)

    if fav.save
      render json: fav, status: :created
    else
      render json: { errors: fav.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    fav = current_user.favourites.find_by(id: params[:id])
    return render json: { error: "Favourite not found" }, status: :not_found unless fav

    fav.destroy
    head :no_content
  end
end
