class Api::V1::ReviewsController < ApplicationController
  before_action :authorized
  before_action :set_product, only: [ :index, :create ]
  before_action :set_review, only: [ :update, :destroy ]

  def index
    render json: @product.reviews.includes(:user), include: :user
  end

  def create
    review = @product.reviews.build(review_params.merge(user: current_user))

    if review.save
      render json: review, status: :created
    else
      render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @review.user != current_user
      return render json: { error: "Unauthorized" }, status: :unauthorized
    end

    if @review.update(review_params)
      render json: @review
    else
      render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @review.user != current_user
      return render json: { error: "Unauthorized" }, status: :unauthorized
    end

    @review.destroy
    head :no_content
  end

  private

  def set_product
    @product = Product.find_by(id: params[:product_id])
    render json: { error: "Product not found" }, status: :not_found unless @product
  end

  def set_review
    @review = Review.find_by(id: params[:id])
    render json: { error: "Review not found" }, status: :not_found unless @review
  end

  def review_params
    params.require(:review).permit(:comment)
  end
end
