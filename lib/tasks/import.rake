namespace :import do
  desc "Import from ods"
  task from_ods: :environment do
    # xlsx = Roo::Excelx.new("./users.ods")
    ods = Roo::OpenOffice.new (Rails.root.join("db", "txt", "users.ods"))

    ods.each(user_id: 'id', name: 'name', family_name: 'family', user_type: 'user_type') do |user_hash|
      if user_hash[:family_name] != 'family'
        # делаем или ищем тип
        user_type = UserType.create_or_find_by!(name: user_hash[:user_type])

        User.where(id: user_hash[:user_id]).first_or_initialize.tap do |user|
          # это user.user_type.id = user_type.id
          user.user_type = user_type
          user.family_name = user_hash[:family_name] unless user_hash[:family_name].nil?
          user.name = user_hash[:name] unless user_hash[:name].nil?
          user.save!
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
