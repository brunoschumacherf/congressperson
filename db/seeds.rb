deputies = []
errors = []
total = 0;
file = file = "#{Rails.root.to_s}/db/Ano-2021.csv"
ceap = Ceap.create({name: "Bruno", email: "Bruno@schumacher.br"})

File.open(file).each do |r|
  begin

    r = r.split(";")
    # puts r[5]
    next if r[5].nil? || (r[5] == "\"sgUF\"") || !r[5].include?("\"BA\"")
    deputy = Deputy.where(document: JSON.parse(r[1]), ceap_id: ceap.id).first
    total += JSON.parse(r[19]).to_i
    unless deputy
      puts "OI"
      data_deputies = {
        name: JSON.parse(r[0]),
        document: JSON.parse(r[1]),
        state: JSON.parse(r[5]),
        photo: "http://www.camara.leg.br/internet/deputado/bandep/#{JSON.parse(r[2])}.jpg",
      }
      puts data_deputies
      deputy = Deputy.create(data_deputies)
      puts "deputy"
      deputy.ceap = ceap
      deputy.save(validate: false)
      deputies << deputy
      puts "teste"
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
      puts "oie"
      expenses = Expense.create(data_expenses)
      expenses.deputy = deputy
      expenses.save(validate: false)
    end
  rescue => error
    puts error
    errors <<  error.message
  end
  if deputies.present?
    deputies.each do |deputado|
      ceap.deputies << deputy
    end
    ceap.total_spend = total
    ceap.save(validate: false)
    puts "OIIIII"
  end
end