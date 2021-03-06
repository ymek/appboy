require 'pry'
require 'dotenv'
require 'bundler/setup'

Bundler.setup
Dotenv.load

require 'appboy'
require 'support/vcr'
require 'support/factory_girl'
require 'support/integrations'

RSpec.configure do |config|
  def test_time
    Time.parse('2016-12-15 00:00:00 -0500').utc
  end

  def appboy_group_id
    ::ENV.fetch('APPBOY_GROUP_ID', 'fake-group-id')
  end

  def appboy_test_segment
    ::ENV.fetch('APPBOY_TEST_SEGMENT', 'fake-test-segment')
  end

  def appboy_schedule_id
    @appboy_schedule_id ||= 'fake-schedule-id'
    @appboy_schedule_id
  end
end
