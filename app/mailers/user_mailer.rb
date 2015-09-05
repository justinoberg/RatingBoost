class UserMailer < ActionMailer::Base
  def notify(review)
    @review = review
    mail(from: @review.name, to: @review.email, subject: "Thank you for your feedback!")
  end
  def warning(review)
    @review = review
    mail(from: @review.name, to: @review.email, subject: "We apologize for your experience!")
  end
end