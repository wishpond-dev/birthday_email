# frozen_string_literal: true

module Email
  module Service
    class DispatchBirthdayCampaign

      EMAIL_CAMPAIGN = "email".freeze

      def dispatch!
        connection = ActiveRecord::Base.connection.raw_connection
        connection.send_query(consented_users_query)
        connection.set_single_row_mode

        connection.get_result.stream_each do |user|
          schedule_email_job(user["id"])
        end
      end

      private

      def consented_users_query
        query = <<-SQL
          SELECT user_consents.* FROM user_consents
          INNER JOIN consents ON user_consents.consent_id=consents.id
          INNER JOIN users ON users.id=user_consents.user_id
          WHERE consents.key='%s'
          AND DATE_PART('day', users.birthdate) = DATE_PART('day', CURRENT_DATE)
          AND DATE_PART('month', users.birthdate) = DATE_PART('month', CURRENT_DATE)
        SQL
        query % EMAIL_CAMPAIGN
      end

      def schedule_email_job(user_id)
        BirthdayCampaignJob.perform_later(user_id)
      end
    end
  end
end

