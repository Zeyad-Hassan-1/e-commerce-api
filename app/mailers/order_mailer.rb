class OrderMailer < ApplicationMailer
  default from: "store@example.com"

  def confirmation_email
    @order = params[:order]
    @user = @order.user

    mail(
      to: @user.email,
      subject: "Your Order ##{@order.id} has been placed"
    )

  end
end
