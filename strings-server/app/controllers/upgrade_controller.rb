class UpgradeController < ApplicationController
  def index
    render json: { message: "Your browser is Firefox, check it out render! © #{Time.now.year}" }.to_json, status: :ok
  end
end
