class UserNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    # UserMailer.welcome_email(user).deliver_now
  end
end
