class RestaurantsController < ApplicationController
  
  def index
    @restaurants = Restaurant.page(params[:page]).per(9) 
    @categories = Category.all
  end

  def show
    @restaurant = Restaurant.find(params[:id]) 
    @comment = Comment.new   
  end

  def feeds
    @recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
    @recent_comments = Comment.order(created_at: :desc).limit(10)
  end

  def dashboard
    @restaurant = Restaurant.find(params[:id])
  end

  def favorite
    @restaurant = Restaurant.find(params[:id])
    @restaurant.favorites.create!(user: current_user)
    #更新收藏數
    @favorites_count = @restaurant.favorites_count;
    @favorites_count = @favorites_count.blank? ? 1 : @favorites_count + 1
    @restaurant.update_columns(favorites_count: @favorites_count)
    redirect_back(fallback_location: root_path)
  end

  def unfavorite
    @restaurant = Restaurant.find(params[:id])
    favorite = Favorite.where(restaurant: @restaurant, user: current_user)
    favorite.destroy_all
    @favorites_count = @restaurant.favorites_count - 1;
    @restaurant.update_columns(favorites_count: @favorites_count)
    redirect_back(fallback_location: root_path)
  end

  def like
    @restaurant =Restaurant.find(params[:id])
    @restaurant.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    @restaurant =Restaurant.find(params[:id])
    like = Like.where(restaurant: @restaurant, user: current_user)
    like.destroy_all
    redirect_back(fallback_location: root_path)
  end

  def ranking
    @restaurants = Restaurant.order(favorites_count: :desc).limit(10)
  end
  
  
end
