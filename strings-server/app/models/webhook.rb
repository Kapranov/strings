class Webhook
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :payload, :type => Text
end
