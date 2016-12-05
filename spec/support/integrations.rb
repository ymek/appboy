require 'active_support/concern'

module Integrations
  extend ActiveSupport::Concern

  included do
    let(:app_group_id) { appboy_group_id }
    let(:segment_id) { appboy_test_segment }
    let(:api) { Appboy::API.new(app_group_id) }
  end

  RSpec.configure do |config|
    config.include self, type: :integrations, file_path: %r(spec/integrations)
  end
end
