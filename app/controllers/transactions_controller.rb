class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource 
  #skip_before_action :current_account, only: [:create]
  # GET /transactions
  # GET /transactions.json
  def index
     if session[:account]
        @transactions = current_account.transactions 
     else   
      @transactions = Transaction.all.includes(:company,:account,:perticular)
     end  
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
    respond_to do |format|
        format.html
        format.pdf do
          render pdf: transaction_path(@transaction)
        end
      end
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    respond_to do |format|
      if @transaction.save
        Notification.amount_transfer(@transaction,current_user).deliver!
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    Notification.amount_destroy(@transaction,current_user).deliver!
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search_results
    @transactions=Transaction.where("transaction_date BETWEEN ? AND ? AND account_id=?",params[:start],params[:end],params[:acc_no])
  end 

  def soft_delete
    @transactions=Transaction.only_deleted
  end  

  def restore
    Transaction.restore(params[:transaction_id])
    redirect_to :back
  end  

  def select_perticular
    @perticular=Perticular.find(params[:perticular_id])
    @perticular_transtype= @perticular.transaction_type
  end  

 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:transaction_date,:company_id, :perticular_id, :transaction_type,:amount,:remark, :transaction_kind,:account_id,:instrument_date,:instrument_number)
    end
end
