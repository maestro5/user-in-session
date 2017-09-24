class UsersController < ApplicationController
  def index
    @users = JSON.parse(session[:users]) if session[:users]
  end

  def create
    User.new(user_params)
    save_in_session
  end

  def update
    User.update(params[:id], user_params)
    save_in_session
  end

  def destroy
    User.destroy(params[:id])
    save_in_session
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name).to_h.symbolize_keys
  end

  def save_in_session
    session[:users] = User.all.to_json
    redirect_to root_path
  end
end
