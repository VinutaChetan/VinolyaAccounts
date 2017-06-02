# Preview all emails at http://localhost:3000/rails/mailers/notification
class NotificationPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notification/amount_transfer
  def amount_transfer
    Notification.amount_transfer
  end

end
