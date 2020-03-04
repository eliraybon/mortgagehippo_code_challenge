class Api::TransactionsController < ApplicationController
  before_action :authenticate

  def index
    @transactions = Transaction.all
    render json: @transactions
  end

  def deposit
    coin = params[:transaction] ? 
      Coin.find_by(id: params[:transaction][:coin_id]) :
      nil

    coin = Coin.where(name: params[:name]) if params[:name]

    if coin.nil? 
      render json: ["No coin found"]
      return
    end

    @deposit = Deposit.new(transaction_params)
    @deposit.user = @current_user

    if @deposit.save
      coin.quantity += 1
      coin.save
      render json: @deposit
    else
      render json: @deposit.errors.full_messages
    end
  end

  def withdrawal
    coin = params[:transaction] ? 
      Coin.find_by(id: params[:transaction][:coin_id]) :
      nil

    coin = Coin.where(name: params[:name]) if params[:name]
    
    if coin.nil? 
      render json: ["No coin found"]
      return
    end

    if coin.quantity.zero?
      render json: ["No more of this coin left"]
      return
    end

    @withdrawal = Withdrawal.new(transaction_params)
    @withdrawal.user = @current_user

    if @withdrawal.save
      coin.quantity -= 1
      coin.save

      if coin.quantity <= 3
        AdminMailer.with(coin: coin).coin_running_low.deliver_now
      end

      render json: @withdrawal
    else
      render json: @withdrawal.errors.full_messages
    end
  end

  private
  def transaction_params
    params.require(:transaction).permit(:coin_id, :type)
  end
end
