module Authentication
  extend ActiveSupport::Concern

  module ClassMethods
    def authenticate(email, password)
      user = find_by(email: email)
      return unless user
      user.send :new_token
      user.authenticate password
    end
  end

  included do
    has_secure_password
    before_create :set_token
    after_find :fix_up_token
    validates :email, uniqueness: true
  end

  def logout
    new_token
  end

  def set_token
    self.token = SecureRandom.hex(16)
  end

  def new_token
    update_columns(token: set_token, updated_at: Time.current)
  end

  def fix_up_token
    new_token if updated_at < 7.days.ago
  end

  private :set_token, :new_token, :fix_up_token
end
