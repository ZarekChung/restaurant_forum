class UsersController < ApplicationController
  before_action :set_restaurant, only: [:edit, :update, :friend_list]
  
  def index
    @users = User.all
  end

  def show
    @users = User.find(params[:id])
    @commented_restaurants = User.find(params[:id]).restaurants.uniq 
    @favorite_restaurants = User.find(params[:id]).favorited_restaurants.uniq
    @followings = User.find(params[:id]).followings
    @followers = User.find(params[:id]).followers
    
    #@freind = User.find(params[:id]).friend
    @freinds = User.find(params[:id]).friended

   #if params[:id] == current_user.id
    #@commented_restaurants = User.find(params[:id]).restaurants 
    #@current_user = User.find(params[:id])
    #end
  end

  def update
   if @users.update_attributes(users_params)    
      flash[:notice] = "users was scuccessfully updated"
      redirect_to user_path(@users)  
    else
      flash.now[:alert] ="users was failed to update"
      render :edit
    end  
  end

  def friend_list
    @user_friends = @users.all_friends
  end

  private

  def set_restaurant
    @users = User.find(params[:id])    
  end

  def users_params
    params.require(:user).permit(:name, :intro, :avatar)  
  end

end
