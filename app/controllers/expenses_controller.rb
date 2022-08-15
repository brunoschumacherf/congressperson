class ExpensesController < ApplicationController
  before_action :set_expenses, only: %i[ index ]
  before_action :set_expense, only: %i[ show ]

  def index
  end

  def show
  end
  private

  def set_expenses
    # @ceap = Ceap.find(params[:ceap_id])
    @deputy =  Deputy.where(id: params[:id]).first
    @expenses = @deputy.expenses
    @higher_expense = @deputy.higher_expense
  end

  def set_expense
    @expense = Expense.find(params[:id])
  end
end
