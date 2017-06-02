require 'test_helper'

class NotificationTest < ActionMailer::TestCase
  test "amount_transfer" do
    mail = Notification.amount_transfer
    assert_equal "Amount transfer", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
