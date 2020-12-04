# frozen_string_literal: true

# spec/whenever_spec.rb
require "rails_helper"

describe "Whenever Schedule" do
  before do
    load "Rakefile"
  end

  it "makes sure `rake` statements exist and it is the send_birthday_emails:run" do
    schedule = Whenever::Test::Schedule.new

    assert Rake::Task.task_defined?(schedule.jobs[:rake].first[:task])

    expect(schedule.jobs[:rake].first[:task]).to eq("send_birthday_emails:run")
  end
end
