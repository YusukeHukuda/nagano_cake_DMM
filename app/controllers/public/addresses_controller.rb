class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = current_customer.address
  end

  def create
    @address = Address.new(address_params)
    if @address.customer_id = current_customer.id
    @address.save
    redirect_to addresses_path
    else
    render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end


  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end


  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address).merge(customer_id: current_customer.id)
  end
end