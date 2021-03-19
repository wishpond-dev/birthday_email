class WishUsersJob < ApplicationJob
  queue_as :default

  def perform
     InformUser.new.send_email
  end
end
