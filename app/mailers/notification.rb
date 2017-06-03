class Notification < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.amount_transfer.subject
  #
  def amount_transfer(transaction,user)
  	@transaction=transaction
    @user = user
    mail to: "vinuta.testing@gmail.com",cc: "#{user.email}",subject: "Amount tranfered today"
  end
end    