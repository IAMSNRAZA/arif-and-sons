class PaymentTransactionsController < ApplicationController
  before_action :set_payment_transaction, only: %i[ show edit update destroy ]

  # GET /payment_transactions or /payment_transactions.json
  def index
    if params["transaction_type"] == 'orders'
      @payment_transactions = current_user.payment_transactions.where.not(order_id: nil).order(id: :desc)
    else
      @payment_transactions = current_user.payment_transactions.order(id: :desc)
    end
    @todays_debit = @payment_transactions.where(transaction_type: 'debit').where("created_at >= ?", Time.zone.now.beginning_of_day).total_debit
    @todays_credit = @payment_transactions.where(transaction_type: 'credit').where("created_at >= ?", Time.zone.now.beginning_of_day).total_credit
  end

  # GET /payment_transactions/1 or /payment_transactions/1.json
  def show
  end

  # GET /payment_transactions/new
  def new
    @payment_transaction = PaymentTransaction.new
  end

  # GET /payment_transactions/1/edit
  def edit
  end

  # POST /payment_transactions or /payment_transactions.json
  def create
    @payment_transaction = PaymentTransaction.new(payment_transaction_params)
    @payment_transaction.user = current_user
    if @payment_transaction.save
      redirect_to payment_transactions_path
      flash[:notice] = "Payment was successfully created."
    else
      flash[:alert] = @payment_transaction.errors.full_messages.join("<br>").html_safe
      redirect_to payment_transactions_path
    end
  end

  # PATCH/PUT /payment_transactions/1 or /payment_transactions/1.json
  def update
    respond_to do |format|
      if @payment_transaction.update(payment_transaction_params)
        format.html { redirect_to payment_transaction_url(@payment_transaction), notice: "Payment transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @payment_transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_transactions/1 or /payment_transactions/1.json
  def destroy
    @payment_transaction.destroy

    respond_to do |format|
      format.html { redirect_to payment_transactions_url, notice: "Payment transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_transaction
      @payment_transaction = PaymentTransaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_transaction_params
      params.require(:payment_transaction).permit(:credit, :debit, :notes)
    end
end
