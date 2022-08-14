class ReadCsvJob < ApplicationJob

  queue_as :default
  def perform(file, ceap)
    deputies = []
    errors = []
    total = 0;
    File.open(file).each do |r|
      begin
        r = r.join(",") if r.is_a?(Array)
        r = r.split(";")

        next if r[5].nil? || (r[5] == "\"sgUF\"")
        deputy = Deputy.where(document: JSON.parse(r[1]), ceap_id: ceap.id).first
        unless deputy
          data_deputies = {
            name: JSON.parse(r[0]),
            document: JSON.parse(r[1]),
            state: JSON.parse(r[5])
          }
          total += JSON.parse(r[19])
          deputy = Deputy.create(data_deputies)
          deputy.ceap = ceap
          deputy.save(validate: false)
          deputies << deputy
        end
        unless Expense.where(establishment: JSON.parse(r[12]), deputy_id: deputy.id).first
          data_expenses = {
            date: JSON.parse(r[16]),
            establishment: JSON.parse(r[12]),
            value: JSON.parse(r[19]),
            note: urlDocumento: JSON.parse(r[30])
          }
          expenses = Expense.create(data_expenses)
          expenses.deputy = deputy
          expenses.save(validate: false)
        end
      rescue => error
        errors <<  error.message
      end
      if deputies.present?
        deputies.each do |deputado|
          ceap.deputies << deputy
        end
        ceap.total_spend = total
        ceap.save(validate: false)
      end
    end
  end
end