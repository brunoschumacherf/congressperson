deputies = []
errors = []
total = 0;
file = file = "#{Rails.root.to_s}/db/Ano-2021.csv"
ceap = Ceap.create({name: "Bruno", email: "Bruno@schumacher.br"})

deputies = []
errors = []
total = 0;
File.open(file).each do |r|
  begin
    r = r.join(",") if r.is_a?(Array)
    r = r.split(";")

    next if r[5].nil? || (r[5] == "\"sgUF\"") || !r[5].include?("\"BA\"")
    total += JSON.parse(r[19]).to_i
    deputy = Deputy.where(document: JSON.parse(r[1]), ceap_id: ceap.id).first
    unless deputy
      data_deputies = {
        name: JSON.parse(r[0]),
        document: JSON.parse(r[1]),
        state: JSON.parse(r[5]),
        photo: "http://www.camara.leg.br/internet/deputado/bandep/#{JSON.parse(r[2])}.jpg"
      }
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
        note: JSON.parse(r[30]),
        phone: JSON.parse(r[14]),
        document:  JSON.parse(r[13])
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