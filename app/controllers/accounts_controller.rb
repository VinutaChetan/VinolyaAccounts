class AccountsController < ApplicationController
 #before_action :authenticate_user! ,except: [:select_balance]
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  #load_and_authorize_resource 
  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all.includes(:bank,:branch,:company)
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show

  end

  def yearwise_acc
    @account= Account.find_by(id: params[:account_id])
  end  

  def monthwise_acc
    @account= Account.find_by(id: params[:account_id])
  end  

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  def select_balance
    @account = Account.find(params[:acc_id])
  end
  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to accounts_path, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def select_account 
    session[:account] = Account.find(params[:account_id]).id
    redirect_to transactions_path, notice: "Account Selected "
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:acc_no, :opening_balance, :bank_id, :branch_id, :acc_type, :current_balance,:company_id,:IFSC)
    end
end
