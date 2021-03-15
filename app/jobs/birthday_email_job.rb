# frozen_string_literal: true

class BirthdayEmailJob < ApplicationJob
  queue_as :default

  def perform
    day_of_year = Time.zone.today.yday

    logger.info "[birthday_mailing] Start processing of birthday emails to day ##{day_of_year}"

    User
      .consented_email_and_birthday_in(day_of_year)
      .find_in_batches
      .with_index do |group, index|
      logger.info "[birthday_mailing] Processing group of users ##{index}"

      group.each {|user| UserMailer.birthday_email(user).deliver_now }
    end

    logger.info "[birthday_mailing] Finished processing of birthday emails to day ##{day_of_year}"
  end
end
