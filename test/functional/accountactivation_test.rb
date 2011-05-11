require 'test_helper'

class AccountactivationTest < ActionMailer::TestCase
  test "sendlink" do
    mail = Accountactivation.sendlink
    assert_equal "Sendlink", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
