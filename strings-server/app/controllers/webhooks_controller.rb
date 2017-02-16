class WebhooksController < ApplicationController
  skip_before_action :authenticate_http
  skip_before_action :authenticate
  skip_before_action :validate_token
  skip_before_action :check_header

  def complete
    return head :ok
  end

  def receive
    if request.headers['Content-Type'] == 'application/json'
      data = JSON.parse(request.body.read)
    else
      data = params.as_json
    end

    Webhook::Received.save(data: data, integration: params[:integration_name])

    puts "<<<<<<<<<<< CREATED WEBHOOK INITIATED >>>>>>>>>>>>>>>"
    render nothing: true, status: 200
  end
end
