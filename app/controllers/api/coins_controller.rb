class Api::CoinsController < ApplicationController
  before_action :authenticate
  
  def index 
    @coins = Coin.all
    render json: @coins
  end

  def show 
    @coin = Coin.find_by(id: params[:id])
    if @coin 
      render json: @coin
    else
      render json: ["Coin not found"], status: 404
    end
  end

  def create
    @coin = Coin.new(coin_params)

    if @coin.save
      render json: @coin
    else 
      render json: @coin.errors.full_messages, status: 422
    end
  end

  def update
    @coin = Coin.find_by(id: params[:id])
    if @coin.nil?
      render json: ["Coin not found"], status: 404 
      return 
    end

    if @coin.update(coin_params)
      render json: @coin
    else 
      render json: @coin.errors.full_messages, status: 422
    end
  end

  def destroy
    @coin = Coin.find_by(id: params[:id])
    if @coin
      render json: @coin.destroy
    else
      render json: ["Coin not found"], status: 404
    end
  end

  def total
    render json: Coin.total
  end

  private
  def coin_params
    params.require(:coin).permit(:name, :value, :quantity)
  end

end
