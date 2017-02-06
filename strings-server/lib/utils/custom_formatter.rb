module Lograge
  module Formatters
    class CustomFormatter < Lograge::Formatters::KeyValue
      def call(data)
        data = data.delete_if do |k|
          [:controller, :action, :format].include? k
        end
        super
      end
    end
  end
end

