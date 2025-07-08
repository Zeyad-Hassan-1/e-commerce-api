module Api
  module V1
    class ProductsController < ApplicationController
      before_action :authorized, except: [ :index, :show ]
      before_action :authorize_admin, only: [ :create, :update, :destroy ]
      before_action :find_product, only: [ :show, :update, :destroy ]
      def index
        page = params.fetch(:page, 1).to_i
        per_page = params.fetch(:per_page, 10).to_i

        if page < 1 || per_page < 1
          return render json: { error: "Invalid pagination parameters" }, status: :bad_request
        end

        per_page = [ per_page, 100 ].min

        products = Product
          .order(created_at: :desc)
          .page(page)
          .per(per_page)

        render json: {
          products: ActiveModelSerializers::SerializableResource.new(products, each_serializer: ProductSerializer),
          meta: {
            current_page: products.current_page,
            next_page: products.next_page,
            prev_page: products.prev_page,
            total_pages: products.total_pages,
            total_count: products.total_count
          }
        }
      rescue ArgumentError => e
        render json: { error: "Invalid pagination parameters" }, status: :bad_request
      end

      def show
        render json: @product
      end

      def create
        product = Product.new(product_params)
        if product.save
          render json: product, status: :created
        else
          render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @product.update(product_params)
          render json: @product
        else
          render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @product.destroy
          head :no_content
        else
          render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
        end
      end


      private
      def find_product
        @product = Product.find_by(id: params[:id])
        render json: { error: "Product not found" }, status: :not_found unless @product
      end

      def product_params
        params.require(:product).permit(:name, :description, :price, colors: [], sizes: [], images: [], categories: [])
      end
    end
  end
end
