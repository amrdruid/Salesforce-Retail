# frozen_string_literal: true

namespace :dealers do
  desc 'Auto generation for valid customers'
  task generate_and_save_to_db: :environment do
    dealers = @salesforce_api_handler.dealers_by_category(Dealer::CATEGORIES[:point_of_sale])
    AddDealersWorker.perform_async(dealers)
  end
end
