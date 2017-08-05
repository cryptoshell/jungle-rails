class ReviewsController < ApplicationController 
  before_action :require_login, only: [:create]

  def create
    @product = Product.find params[:product_id]
    @review = @product.reviews.new(review_params)
    @review.user = current_user
      if @review.save
        redirect_to product_path(@product.id)
      else
        redirect_to @product
      end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to product_path(@review.product_id), notice: 'Review was successfully destroyed.'
  end

  private
    def require_login
        unless current_user
          flash[:error] = "You must be logged in to add a review"
          redirect_to login_path
        end
    end

    def review_params
      params.require(:review).permit(:description, :rating)
    end
end