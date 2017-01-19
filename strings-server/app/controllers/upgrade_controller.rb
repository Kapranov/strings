class UpgradeController < ApplicationController
  def index
    render plain: "Your browser is old!"
  end
end
