module ExpensesHelper
  def details(expense)
    "#{expenses_show_path}?id=#{expense.id}"
  end
end
