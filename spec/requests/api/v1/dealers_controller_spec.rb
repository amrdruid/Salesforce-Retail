require 'rails_helper'
Sidekiq::Testing.fake!

RSpec.describe Api::V1::DealersController, type: :controller do
  describe 'GET /dealers_within_range' do
    before(:all) do
      FactoryBot.create(:dealer, latitude: 53.2451022, longitude: -6.238335)
      FactoryBot.create(:dealer, latitude: 53.008769, longitude: -6.1056711)
      FactoryBot.create(:dealer, latitude: 53.1302756, longitude: -6.2397222)
      FactoryBot.create(:dealer, latitude: 54.0894797, longitude: -6.18671)
      FactoryBot.create(:dealer, latitude: 51.92893, longitude: -10.27699)
    end

    it 'returns dealers that are within 100KM range' do
      get :dealers_within_range, params: { latitude: 53.339428, longitude: -6.257664 }

      dealers_in_range = 4
      expect(JSON.parse(response.body)['data'].count).to eq(dealers_in_range)
    end
  end

  describe 'POST /add_point_of_sales_dealers' do
    it 'adds a job to the queue' do
      expect do
        post :add_point_of_sales_dealers
      end.to change(AddDealersWorker.jobs, :size).by(1)
    end

    it 'renders success message as json' do
      post :add_point_of_sales_dealers
      expect(response.body).to eq('Point of Sales Dealers will be added to the database in few minutes')
    end
  end
end
