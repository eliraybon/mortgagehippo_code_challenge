class Api::UsersController < ApplicationController
  before_action :authenticate, only: [:transactions]

  def create 
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors.full_messages
    end
  end

  def transactions
    user = User.find_by(id: params[:id])
    if user.nil?
      render json: ["No user found"]
      return
    end
    @transactions = user.transactions
    render json: @transactions
  end

  private
  def user_params
    params.require(:user).permit(:email)
  end

end
