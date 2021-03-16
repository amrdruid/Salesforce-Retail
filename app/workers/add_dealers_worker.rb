# frozen_string_literal: true

class AddDealersWorker
  include Sidekiq::Worker

  def perform
    salesforce_api_handler = Services::SalesforceApiHandler.new
    dealers = salesforce_api_handler.dealers_by_category(category: Dealer::CATEGORIES[:point_of_sale])

    # If there are too many we probably group them in batches and use ActiveRecord::Transaction
    dealer_builder = DealerBuilder.new

    dealers.each do |dealer_info|
      build_and_save_dealer(dealer_builder: dealer_builder, dealer_info: dealer_info)
    rescue ActiveRecord::RecordInvalid => e
      Sentry.capture_exception(e)
    end
  end

  private

  def build_and_save_dealer(dealer_builder:, dealer_info:)
    return if Dealer.find_by(sf_id: dealer_info['Id']).present?

    # TODO: Map salesforce values to the correct column and use `dealer_builder.send("#{mapped_value}=")` for creation
    dealer_builder.sf_id = dealer_info['Id']
    dealer_builder.name = dealer_info['Name']
    dealer_builder.category = dealer_info['E_Shop_Dealer__c']
    dealer_builder.longitude = dealer_info['Dealer_Longitude__c']
    dealer_builder.latitude = dealer_info['Dealer_Latitude__c']
    dealer_builder.street = dealer_info['POS_Street__c']
    dealer_builder.zip = dealer_info['POS_ZIP__c']
    dealer_builder.country = dealer_info['POS_Country__c']
    dealer_builder.state = dealer_info['POS_State__c']
    dealer_builder.city = dealer_info['POS_City__c']
    dealer_builder.phone = dealer_info['POS_Phone__c']

    dealer_builder.dealer.save!
  end
end
