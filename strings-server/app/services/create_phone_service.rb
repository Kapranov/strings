class CreatePhoneService
  def call
    Phone.create(user: User.first, name: 'home', phone_number: Rails.application.secrets.admin_phone_home.to_s)
    Phone.create(user: User.first, name: 'cell', phone_number: Rails.application.secrets.admin_phone_cell.to_s)
    Phone.create(user: User.first, name: 'work', phone_number: Rails.application.secrets.admin_phone_work.to_s)
  end
end
