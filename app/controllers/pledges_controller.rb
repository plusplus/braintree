class PledgesController < ApplicationController

  def new
    @client_token = Braintree::ClientToken.generate
    @pledge       = Pledge.new
  end

  def create
    pledge = Pledge.new(pledge_params)
    if pledge.save
      result = Braintree::Transaction.sale(
        :amount => "#{pledge.amount}.00",
        :payment_method_nonce => params[:payment_method_nonce]
      )
      if result.success?
        pledge.transaction_reference = result.transaction.id
        pledge.save
        redirect_to(pledge_path(pledge))
      else
        @client_token = Braintree::ClientToken.generate
        flash.now[:warning] = result.transaction.status
        render :new
      end
    end
  end

  def show
    @pledge = Pledge.find(params[:id])
  end

  private

  def pledge_params
    params.require(:pledge).permit(:name, :amount)
  end
end
