class Public::CustomersController < ApplicationController

  before_action :authenticate_customer!

  def edit
    @customer = Customer.find(current_customer.id)
  end

  def show
    @customer = Customer.find(current_customer.id)
  end

  def update
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
      redirect_to customers_path, notice: "変更を保存しました"
    else
      render :edit
    end
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    @customer.is_deleted = true
    @customer.save
    reset_session

    redirect_to root_path
    flash[:notice] = "退会処理を実行いたしました"
  end

private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
  end
end
