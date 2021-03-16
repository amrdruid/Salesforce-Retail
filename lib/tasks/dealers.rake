# frozen_string_literal: true

namespace :dealers do
  desc 'Auto generation for valid customers'
  task generate_and_save_to_db: :environment do
    AddDealersWorker.perform_async
  end
end
