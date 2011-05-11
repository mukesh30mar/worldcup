class Accountactivation < ActionMailer::Base
  default :from => "worlcup2011@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.accountactivation.sendlink.subject
  #
  def sendlink(coach,host)
    @greeting = "Hi"

    mail :to => coach.email,
         :subject => "please click the link below for account activation",
         #:body => link_to(coaches_url,coaches_path,:host => "localhost")
         :body => "http://#{host}/activate/#{coach.activation_code}"
  end
end
