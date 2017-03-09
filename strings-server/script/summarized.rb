require File.expand_path('../../config/environment', __FILE__)
require 'benchmark'

statuses = TruckStatus.order(:id).limit(10_000)

MultiJson.engine = :json_gem

Benchmark.bm do |x|
  x.report 'default  ' do
    statuses.to_json
  end

  x.report 'attrs    ' do
    statuses.to_json methods: [:latitude, :longitude, :timestamp, :virtual_odometer]
  end

  x.report 'select   ' do
    statuses.select([:latitude, :longitude, :timestamp, :virtual_odometer]).to_json methods: [:latitude, :longitude, :timestamp, :virtual_odometer]
  end

  x.report 'lightning' do
    statuses.lightning.to_json
  end

  x.report 'json     ' do
    JSON.dump statuses.lightning
  end

  x.report 'yajl     ' do
    Yajl.dump statuses.lightning
  end

  x.report 'oj       ' do
    Oj.dump statuses.lightning, mode: :compat
  end
end