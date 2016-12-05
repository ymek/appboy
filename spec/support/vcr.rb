require 'vcr'

VCR.configure do |config|
  config.filter_sensitive_data('<APPBOY_GROUP_ID>') { appboy_group_id }
  config.filter_sensitive_data('<APPBOY_TEST_SEGMENT>') { appboy_test_segment }

  config.cassette_library_dir = 'spec/fixtures/responses'

  config.default_cassette_options = {
    match_requests_on: [:method, :uri, :body]
  }

  config.configure_rspec_metadata!

  config.hook_into :webmock
end

