class ReviewsController < ApplicationController
    before_action :set_restaurant, only: [:index, :new, :create]

  def index
    @reviews = Review.where(restaurant_id: @restaurant)
  end

  def new
    # we need @restaurant in `simple_form_for`
    # @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review.restaurant = @restaurant
    if @review.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end
