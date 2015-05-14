class UserMailer < ActionMailer::Base
  include Devise::Mailers::Helpers
  default from: 'andrej_kuranov@mail.ru'

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome')
  end

  def csv_mail(user, csv)
    attachments['user.csv'] = csv
    mail(to: user.email, subject: 'Csv mail')
  end
end
