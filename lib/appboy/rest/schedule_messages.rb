module Appboy
  module REST
    class ScheduleMessages < Base
      attr_reader :app_group_id, :send_at, :messages, :segment_id, :local_timezone, :external_user_ids, :campaign_id, :schedule_id

      def initialize(app_group_id, send_at:, messages: [], segment_id: nil, external_user_ids: [], campaign_id: nil, local_timezone: false, schedule_id: nil)
        @app_group_id = app_group_id
        @send_at = send_at
        @messages = messages
        @segment_id = segment_id
        @external_user_ids = external_user_ids
        @local_timezone = local_timezone
        @campaign_id = campaign_id
        @schedule_id = schedule_id
      end

      def perform
        if schedule_id.nil?
          create_scheduled_push
        else
          update_scheduled_push
        end
      end

      private

      def update_scheduled_push
        http.post(
          '/messages/schedule/update',
          post_params.merge(schedule_id: schedule_id)
        )
      end

      def create_scheduled_push
        http.post('/messages/schedule/create', post_params)
      end

      def post_params
        {
          app_group_id: app_group_id,
          external_user_ids: external_user_ids,
          segment_id: segment_id,
          campaign_id: campaign_id,
          messages: messages,
          schedule: {
            time: send_at,
            in_local_time: local_timezone
          }
        }
      end
    end
  end
end
