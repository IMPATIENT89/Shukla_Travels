class UserMailer < ApplicationMailer
  def user_confirmation(user)
    @user = user
    mail to: @user.email, subject: "Thanks for joining Shukla Travels!"
  end
end
