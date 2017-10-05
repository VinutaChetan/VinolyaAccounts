class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource 
  #skip_before_action :current_account, only: [:create]
  # GET /transactions
  # GET /transactions.json
  def index
     if session[:account]
        @transactions = current_account.transactions.includes(:company,:account,:perticular)
     else   
      @transactions = Transaction.all.includes(:company,:account,:perticular)
     end  
     respond_to do |format|
     format.html
        format.pdf do
          render pdf: transactions_path(@transactions)
        end
      format.xls
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

    @perticular =Perticular.new
  end

  # GET /transactions/1/edit
  def edit
    @perticular = Perticular.new
  end

  # POST /transactions
  # POST /transactions.json
  def create
  @transaction = Transaction.new(transaction_params)
  @perticular = Perticular.new
  #@transaction.balance = current_account.current_balance

  # set the value for the transaction date 
  @transaction.formulate_date(params[:transaction][:formatted_date])
  # set the value for the instrument date 
  @transaction.formulateinstru_date(params[:transaction][:formattedinstru_date])
    respond_to do |format|
      if @transaction.save
        #Notification.amount_transfer(@transaction,current_user).deliver!
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
        format.js
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      @perticular = Perticular.new
      @transaction.formulate_date(params[:transaction][:formatted_date])
      @transaction.formulateinstru_date(params[:transaction][:formattedinstru_date])
      #amount_was = @transaction.amount_was
      #binding.pry
      if @transaction.update(transaction_params)
        @transaction.cascade
        #@transaction.update_current_account_balance
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
        format.js
      end
    end

  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    #Notification.amount_destroy(@transaction,current_user).deliver!
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search_results
   
    params_start_date = params[:start].split("-").reverse
    if(!(params_start_date.empty?) )
      start_year = "20" + params_start_date.first
      full_start_date = start_year + "-" + params_start_date[1] + "-" + params_start_date[2]
    end

    params_end_date = params[:end].split("-").reverse
    if(!(params_end_date.empty?) )
      end_year = "20" + params_end_date.first
      full_end_date = end_year + "-" + params_end_date[1] + "-" + params_end_date[2]
    end
      @transactions = Transaction.where("transaction_date BETWEEN ? AND ? AND account_id=?",full_start_date,full_end_date,params[:acc_no])
    
    respond_to do |format|
      format.html
      format.xls
      format.pdf do
          render pdf: transactions_search_results_path(:start => params[:start], :end => params[:end], :acc_no => params[:acc_no])
      end

      
    end

  end 

  def soft_delete
    @transactions=Transaction.only_deleted

    respond_to do |format|
    format.html  
    format.pdf do
          render pdf: transactions_soft_delete_path
    end
  end
  end  

  def restore
    Transaction.restore(params[:transaction_id])
    @transaction = Transaction.find(params[:transaction_id])
    @transaction.restore_transaction
    redirect_to @transaction
  end  

  def select_perticular
    @perticular=Perticular.find(params[:perticular_id])   
  end  

  def print_preview
    @transaction=Transaction.find(params[:transaction_id])
  end  

  def search_printpreview
    params_start_date = params[:start_date].split("-").reverse
    start_year = "20" + params_start_date.first
    full_start_date = start_year + "-" + params_start_date[1] + "-" + params_start_date[2]

    params_end_date = params[:end_date].split("-").reverse
    end_year = "20" + params_end_date.first
    full_end_date = end_year + "-" + params_end_date[1] + "-" + params_end_date[2]

    @transactions=Transaction.where("transaction_date BETWEEN ? AND ? AND account_id=?",full_start_date,full_end_date ,params[:account_no])
  end 

  def softdelete_pp
    @transactions=Transaction.only_deleted
    binding.pry
  end 

  def daily_statement
    @accounts = Account.where(id: Transaction.where('transaction_date =?',Date.today).pluck(:account_id).uniq)
    respond_to do |format|
     format.html
     format.xls
        format.pdf do
          render pdf: transactions_path(@transactions)
        end
      end  
  end  

  def weekly_statement
    @accounts = Account.where(id: Transaction.where( 'transaction_date>= ? AND transaction_date <= ?',Date.today.beginning_of_week() ,Date.today.end_of_week()).pluck(:account_id).uniq)

    respond_to do |format|
     format.html
     format.xls
        format.pdf do
          render pdf: transactions_path(@transactions)
        end
      end  
  end

  def weekly_results_pp
    @transactions=Transaction.where('transaction_date>= ? AND transaction_date <= ? AND account_id = ?',Date.today.beginning_of_week() ,Date.today.end_of_week(), params[:account_id])
  end  

  def daily_results_pp
    @transactions =Transaction.where('transaction_date=? AND account_id=?',Date.today, params[:account_id])
  end  

 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:company_id, :perticular_id, :transaction_type,:amount,:remark, :transaction_kind,:account_id,:formattedinstru_date,:instrument_number, :formatted_date)
    end
end
