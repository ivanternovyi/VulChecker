require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe FetchVulnerabilitiesJob, type: :job do
  include ActiveJob::TestHelper

  it "should enqueue self" do
    expect {
      FetchVulnerabilitiesJob.perform_now
    }.to have_enqueued_job
  end

  it "should be in default queue" do
    expect(FetchVulnerabilitiesJob.new.queue_name).to eq('default')
  end

  it "should enqueue sidekiq worker" do
    FetchVulnerabilitiesWorker.clear
    expect {
      FetchVulnerabilitiesWorker.perform_async
    }.to change(FetchVulnerabilitiesWorker.jobs, :size).by(1)
  end
end
