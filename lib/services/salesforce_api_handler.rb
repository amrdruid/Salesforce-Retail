# frozen_string_literal: true

module Services
  # This class gets the distance between two points
  # and checks if distance is valid
  class SalesforceApiHandler
    require 'restforce'

    def initialize
      @client = Restforce.new(
        host: ENV['salesforce_host'],
        username: ENV['salesforce_username'],
        password: ENV['salesforce_password'],
        client_id: ENV['salesforce_client_id'],
        client_secret: ENV['salesforce_client_secret']
      )

      @client.authenticate!
    end

    def dealers_by_category(category:)
      # `expalin` returns JSON - JSON needed to be returned for sidekiq
      @client.explain('SELECT ALL from Account WHERE E_Shop_Dealer__c = ?', category)
    end
  end
end
