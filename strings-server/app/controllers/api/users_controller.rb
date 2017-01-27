class API::UsersController < ApplicationController

  def index
    @users = User.all
    # render :json => MultiJson.dump(@users)
    # render :json => MultiJson.dump({ data: @users.map { |i| serializeitems(i) } })
    render :json => MultiJson.dump(json_for(@users), mode: :compat)
  end

  private

  def serializeitems(item)
    json = hashfor(item, %w(id first_name last_name middle_name token email description))
    json.compat
  end

  def hashfor(model, attributes)
    res = {}
    attributes.map do |attr|
      res[attr] = model.send attr
    end
    res
  end
end
