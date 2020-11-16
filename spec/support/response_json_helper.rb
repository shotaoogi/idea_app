# frozen_string_literal: true

module ResponseJsonHelper
  def response_json
    JSON.parse(response.body, symbolize_names: true)
  end
end

RSpec.configure do |config|
  config.include(ResponseJsonHelper, type: :request)
end
