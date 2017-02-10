# Mime::EXTENSION_LOOKUP.each { |m| puts m}

api_mime_types = %W(
  text/x-json
  application/json
  application/jsonrequest
  application/vnd.api+json
)

# Mime::Type.register "application/vnd.api+json", :json
# Mime::Type.register 'application/vnd.api+json', :json, api_mime_types
Mime::Type.unregister :json
Mime::Type.register 'application/json', :json, api_mime_types
