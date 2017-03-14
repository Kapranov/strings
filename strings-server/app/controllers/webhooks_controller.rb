class WebhooksController < ApplicationController
  def index;  webhook; end
  def create; webhook; end
  def show;   webhook; end
  def update; webhook; end
  def delete; webhook; end

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

  private

  def webhook
    WebhookJob.perform_later(params.to_json)
    render(status: :accepted, plain:"OK")
  end
end
