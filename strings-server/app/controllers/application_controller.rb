class ApplicationController < ActionController::API
  # after_action :set_online

  private

  def set_online
    $redis.set("test_key", "Online!")
  end
end
