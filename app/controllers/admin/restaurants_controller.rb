class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin


  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      #flash 會留到下一個request
      flash[:notice] = "restaurant was scuccessfully created"
      redirect_to admin_restaurants_path
    else
      #flash.now 只存在現在這個request
      flash.now[:alert] = "restaurant was failed to create" 
      render :new
    end
  end


  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :tel, :address, :description, :opening_hours)
    
  end
end
