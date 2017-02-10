api_mime_types = %W(
  application/vnd.api+json
  text/x-json
  application/json
)

# Mime::Type.register "application/vnd.api+json", :json
# Mime::Type.register 'application/vnd.api+json', :json, api_mime_types
Mime::Type.unregister :json
Mime::Type.register 'application/json', :json, api_mime_types
