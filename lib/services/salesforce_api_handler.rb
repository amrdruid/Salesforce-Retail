# frozen_string_literal: true

module Services
  # This class gets the distance between two points
  # and checks if distance is valid
  class SalesforceApiHandler
    require 'restforce'

    attr_reader :client

    def initialize
      @client = Restforce.new(
        host: ENV['salesforce_host'],
        username: ENV['salesforce_username'],
        password: ENV['salesforce_password'],
        security_token: ENV['salesforce_security_token'],
        client_id: ENV['salesforce_client_id'],
        client_secret: ENV['salesforce_client_secret'],
        api_version: ENV['salesforce_api_version']
      )

      @client.authenticate!
    end

    def dealers_by_category(category: 'Dealer and Point of Sale')
      query = ActiveRecord::Base.sanitize_sql("SELECT Id, E_Shop_Dealer__c, Name, POS_Street__c, POS_City__c,
                                               POS_ZIP__c, POS_Country__c, POS_State__c, POS_Phone__c, Dealer_Latitude__c,
                                               Dealer_Longitude__c FROM Account WHERE E_Shop_Dealer__c = '#{category}'")

      dealers = @client.query(query)
      dealers.map(&:to_hash)
    end
  end
end
