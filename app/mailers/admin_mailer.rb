class AdminMailer < ApplicationMailer
  default to: -> { Admin.pluck(:email) }

  def coin_running_low
    @coin = params[:coin]
    subject = @coin.quantity.zero? ? 
      "We're all out of #{@coin.name.capitalize.pluralize}!" :
      "#{@coin.name.capitalize.pluralize} are running low!"
    mail(subject: subject)
  end
end
