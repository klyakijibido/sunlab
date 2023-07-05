namespace :import do
  desc "Import from ods"
  task from_ods: :environment do
    # xlsx = Roo::Excelx.new("./users.ods")
    ods = Roo::OpenOffice.new (Rails.root.join("db", "xls", "1570-0504.ods"))

    ods.each(name: 'Наименование', artic: 'Артикул', razd: 'Разделка', price: 'Цена магазина', code: 'код') do |hash|
      if hash[:family_name] != 'family'
        # делаем или ищем тип
        # user_type = UserType.create_or_find_by!(name: hash[:user_type])

        Tovar.where(code: hash[:code]).first_or_initialize.tap do |tovar|
          # это tovar.user_type.id = user_type.id
          # tovar.user_type = user_type
          tovar.name = hash[:name]
          tovar.artic = hash[:artic] unless hash[:artic].nil?
          tovar.razd = hash[:razd] unless hash[:razd].nil?
          tovar.price = hash[:price]
          tovar.code = hash[:code]
          tovar.save!
        end
      end
    rescue ActiveRecord::RecordInvalid => error
      debugger
      Rails.logger.error error.message
      ods.close
    end
    ods.close
  end
end
