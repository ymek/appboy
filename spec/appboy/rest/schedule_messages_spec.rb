require 'spec_helper'

describe Appboy::REST::ScheduleMessages do
  let(:http) { double(:http) }
  let(:messages) { [build(:messages)] }

  let(:create_payload) {
    {
      send_at: :send_at,
      segment_id: :segment_id,
      external_user_ids: :external_user_ids,
      campaign_id: :campaign_id,
      messages: messages,
      local_timezone: :in_local_time
    }
  }

  let(:update_payload) {
    {
      send_at: :send_at,
      schedule_id: :schedule_id,
      segment_id: :segment_id,
      external_user_ids: :external_user_ids,
      campaign_id: :campaign_id,
      messages: messages,
      local_timezone: :in_local_time
    }
  }

  let(:app_group_id) { :app_group_id }

  before { subject.http = http }

  context 'scheduled message creation' do
    subject { described_class.new(app_group_id, create_payload) }

    it 'makes an http call to the schedule messages create endpoint' do
      expect_schedule_messages_create_http_call

      subject.perform
    end
  end

  context 'scheduled message update' do
    subject { described_class.new(app_group_id, update_payload) }

    it 'makes an http call to the schedule messages update endpoint' do
      expect_schedule_messages_update_http_call

      subject.perform
    end
  end

  def expect_schedule_messages_create_http_call
    expect(http).to receive(:post).with('/messages/schedule/create', post_params)
  end

  def expect_schedule_messages_update_http_call
    expect(http).to receive(:post).with('/messages/schedule/update', post_params.merge(schedule_id: :schedule_id))
  end

  def post_params
    {
      app_group_id: app_group_id,
      external_user_ids: :external_user_ids,
      segment_id: :segment_id,
      campaign_id: :campaign_id,
      messages: messages,
      schedule: {
        time: :send_at,
        in_local_time: :in_local_time
      }
    }
  end
end
