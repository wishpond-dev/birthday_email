ActionMailer::DeliveryJob.rescue_from(StandardError) do |exception|
  Rails.logger.error "Original record not found: #{@serialized_arguments.join(', ')}"
end