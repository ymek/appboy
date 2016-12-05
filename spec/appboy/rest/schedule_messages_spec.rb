require 'spec_helper'

describe Appboy::REST::ScheduleMessages do
  let(:http) { double(:http) }
   let(:messages) { [build(:messages)] }

  let(:payload) {{
    send_at: :send_at,
    segment_id: :segment_id,
    external_user_ids: :external_user_ids,
    campaign_id: :campaign_id,
    messages: messages,
    local_timezone: :in_local_time
  }}

  let(:app_group_id) { :app_group_id }

  subject { described_class.new(app_group_id, payload) }

  before { subject.http = http }

  it 'makes an http call to the schedule messages endpoint' do
    expect_schedule_messages_http_call

    subject.perform
  end

  def expect_schedule_messages_http_call
    expect(http).to receive(:post).with('/messages/schedule/create', {
      app_group_id: app_group_id,
      external_user_ids: :external_user_ids,
      segment_id: :segment_id,
      campaign_id: :campaign_id,
      messages: messages,
      schedule: {
        time: :send_at,
        in_local_time: :in_local_time
      }
    })
  end
end
