class CreateAdminService
  def call
    FactoryGirl.create :user,
      first_name: Rails.application.secrets.admin_first_name.to_s,
      last_name: Rails.application.secrets.admin_last_name.to_s,
      middle_name: Rails.application.secrets.admin_middle_name.to_s,
      email: Rails.application.secrets.admin_email.to_s,
      password: Rails.application.secrets.admin_password.to_s,
      description: Rails.application.secrets.admin_description.to_s,
      admin: true,
      role: User.roles[0],
      state: 'active'
  end

  def cell
    FactoryGirl.create :phone,
      user: User.first,
      name: 'cell',
      phone_number: Rails.application.secrets.admin_phone_cell.to_s
  end

  def work
    FactoryGirl.create :phone,
      user: User.first,
      name: 'work',
      phone_number: Rails.application.secrets.admin_phone_work.to_s
  end

  def home
    FactoryGirl.create :phone,
      user: User.first,
      name: 'home',
      phone_number: Rails.application.secrets.admin_phone_home.to_s
  end
end
