class Admin::RestaurantsController < Admin::BaseController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]


  def index
    @restaurants = Restaurant.page(params[:page]).per(10)
    session[:page] = params[:page]
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

  def update
    if @restaurant.update_attributes(restaurant_params)    
      flash[:notice] = "restaurant was scuccessfully updated"
      redirect_to admin_restaurant_path(@restaurant)  
    else
      flash.now[:alert] ="reastaurant was failed to update"
      render :edit
    end
  end


  def destroy
    @restaurant.destroy
    flash[:notice] = "restaurant was deleted!"
    redirect_to admin_restaurants_path       
  end

  private
 
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])    
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :tel, :address, :description, :opening_hours, :image , :category_id)
    
  end
end
