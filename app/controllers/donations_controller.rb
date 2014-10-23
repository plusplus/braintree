class DonationsController < ApplicationController
  def new
    @client_token = Braintree::ClientToken.generate
  end

  def create
  end

  def show
  end
end
