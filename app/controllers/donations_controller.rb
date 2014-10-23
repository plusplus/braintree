class DonationsController < ApplicationController
  def new
    @client_token = Braintree::ClientToken.generate
  end

  def create
    nonce = params[:payment_method_nonce]
    result = Braintree::Transaction.sale(
      :amount => "100.00",
      :payment_method_nonce => nonce
    )
    if result.success?
      redirect_to donation_path
    else
      flash.now[:warning] = result.transaction.status
      render :new
    end
  end

  def show
  end
end
