class UsersController < ApplicationController
  def index
    @users = users_collection.all
    @user = User.new
  end

  def create
    @user = User.new(user_params.merge!(id: users_collection.generate_new_id))
    if @user.valid?
      users_collection.add @user
      redirect_to root_path
    else
      @users = users_collection.all
      render :index
    end
  end

  def update
    @user = users_collection.find(params[:id])
    if @user.update(user_params)
      users_collection.update(@user)
      redirect_to root_path
    else
      @users = users_collection.all
      render :index
    end
  end

  def destroy
    users_collection.destroy(params[:id])
    redirect_to root_path
  end

  private

  def users_collection
    storage = Storage.new(session, UserSerializer.new)
    UserList.new(storage)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name).to_h.symbolize_keys
  end
end
