class UserMailer < ApplicationMailer
  default from: 'no-reply@example.com' # Change to your desired sender email

  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/login' # URL for the login page
    mail(to: @user.email, subject: 'Welcome to Our Application!')
  end
end
