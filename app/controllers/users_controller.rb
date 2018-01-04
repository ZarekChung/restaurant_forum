class UsersController < ApplicationController
  before_action :set_restaurant, only: [:edit, :update]
  
  def show
    @users = User.all 
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

  private

  def set_restaurant
    @users = User.find(params[:id])    
  end

  def users_params
    params.require(:user).permit(:name, :intro, :avatar)  
  end

end