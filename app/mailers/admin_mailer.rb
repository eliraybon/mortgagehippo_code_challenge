class AdminMailer < ApplicationMailer
  default to: -> { Admin.pluck(:email) }, from: 'elr0615@gmail.com'

  def coin_running_low
    @coin = params[:coin]
    mail(subject: "#{@coin.name.capitalize.pluralize} are running low!")
  end
end
