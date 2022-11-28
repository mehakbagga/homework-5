class UsersController < ApplicationController

  before_action :find_user, except: [:new, :create]
  before_action :authorize_user!, except: [:new, :create]

  def new
      @user = User.new
  end

  def create
      @user = User.new params.require(:user).permit!
      if @user.save
          session[:user_id] = @user.id 
          redirect_to root_path, notice: "Successfully signed up"
      else  
          render :new, status: 303
      end
  end

  def edit
  end

  def update
      @user.update params.require(:user).permit!
      if @user.save
          redirect_to root_path, notice: "Successfully updated your account"
      else 
          render :edit, status: 303
      end
  end

  def change_password
  end

  def patch_changed_password

      #if params.require(:user).permit(:current_password) != params.require(:user).permit(:password)
         
          if @user.authenticate(params[:user][:current_password])
              if params[:user][:current_password] != params[:user][:password]
                  @user.update(params.require(:user).permit(:password, :password_confirmation))
                  if @user.save
                      redirect_to root_path, notice: "Password updated" and return  
                  end
              end
          end
          render :change_password
  end

  private

  def find_user
      @user = User.find params[:id]
  end
  
  def authorize_user!
      redirect_to root_path, notice: "Not Authorized" unless can?(:crud, @user)
  end
end