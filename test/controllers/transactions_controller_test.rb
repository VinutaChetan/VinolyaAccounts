require 'test_helper'

class TransactionsControllerTest < ActionController::TestCase
  setup do
    @transaction = transactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transaction" do
    assert_difference('Transaction.count') do
      post :create, transaction: { perticular_id: @transaction.perticular_id, remark: @transaction.remark, transaction_date: @transaction.transaction_date, transaction_kind: @transaction.transaction_kind, transaction_type: @transaction.transaction_type }
    end

    assert_redirected_to transaction_path(assigns(:transaction))
  end

  test "should show transaction" do
    get :show, id: @transaction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @transaction
    assert_response :success
  end

  test "should update transaction" do
    patch :update, id: @transaction, transaction: { perticular_id: @transaction.perticular_id, remark: @transaction.remark, transaction_date: @transaction.transaction_date, transaction_kind: @transaction.transaction_kind, transaction_type: @transaction.transaction_type }
    assert_redirected_to transaction_path(assigns(:transaction))
  end

  test "should destroy transaction" do
    assert_difference('Transaction.count', -1) do
      delete :destroy, id: @transaction
    end

    assert_redirected_to transactions_path
  end
end
