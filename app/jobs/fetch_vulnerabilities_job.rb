class FetchVulnerabilitiesJob < ActiveJob::Base
  queue_as :default

  def perform
    FetchVulnerabilitiesWorker.perform_async
    FetchVulnerabilitiesJob.set(wait: 10.minutes).perform_later
  end
end
