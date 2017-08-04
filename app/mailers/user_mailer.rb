class UserMailer < ApplicationMailer
  default from: "no-reply@jungle.com"
 
  def receipt_email(order)
    @order = order
    @url = 'http://localhost:3000/'
    mail(to: @order.email, subject: @order.id)
  end
end
