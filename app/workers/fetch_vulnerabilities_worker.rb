class FetchVulnerabilitiesWorker
  include Sidekiq::Worker
  sidekiq_options retry: true

  def perform
    ParseVulnerabilitiesService.new.call
  end
end
