# app/mailers/send_mailer.rb
class SendMailer < ApplicationMailer
  def send_email(to)
    mail(to: to, subject: "Test Email", body: "Hello from Rails + SendGrid!")
  end
end
