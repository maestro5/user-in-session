class UsersController < ApplicationController
  before_action :init_storage

  def index
    @users = @storage.all
  end

  def create
    @storage.add(user_params)
    redirect_to root_path
  end

  def update
    @storage.update(params[:id], user_params)
    redirect_to root_path
  end

  def destroy
    @storage.destroy(params[:id])
    redirect_to root_path
  end

  private

  def init_storage
    @storage = UserList.new(session)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name).to_h.symbolize_keys
  end
end
