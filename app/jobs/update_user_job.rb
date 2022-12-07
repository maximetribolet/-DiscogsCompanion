class UpdateUserJob < ApplicationJob
  queue_as :default

  def perform(user)
    puts "updating Matches"
    # TODO: perform a time consuming task like Clearbit's Enrichment API.
    sleep 2
    puts "Done! Enriched #{user.email} with Clearbit"
  end
end

