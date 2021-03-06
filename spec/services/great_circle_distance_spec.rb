# frozen_string_literal: true

require 'rails_helper'

describe Services::GreatCircleDistance do
  before(:all) do
    # This array contains 5 customers within the range of the given latitude and longitude
    within_range = [{ 'latitude' => '53.2451022', 'longitude' => '-6.238335' },
                    { 'latitude' => '53.008769', 'longitude' => '-6.1056711' },
                    { 'latitude' => '53.1302756', 'longitude' => '-6.2397222' },
                    { 'latitude' => '54.0894797', 'longitude' => '-6.18671' }]

    outside_range = [{ 'latitude' => '53.1229599', 'longitude' => '-6.2705202' },
                     { 'latitude' => '52.833502', 'longitude' => '-8.522366' },
                     { 'latitude' => '51.92893', 'longitude' => '-10.27699' }]

    @customers = (within_range + outside_range).map do |range|
      FactoryBot.create(:dealer, latitude: range['latitude'], longitude: range['longitude'])
    end
  end

  describe 'constants' do
    it 'validates EARTH_MEAN_RADIUS_IN_KMS' do
      expect(Services::GreatCircleDistance::EARTH_MEAN_RADIUS_IN_KMS).to eq(6371.009)
    end
    it 'validates OFFICE_LATITUDE' do
      expect(Services::GreatCircleDistance::MAX_DISTANCE_FROM_CURRENT_LOCATION).to eq(100)
    end
  end

  describe 'logic' do
    let(:obj) { Services::GreatCircleDistance.new(@customers, 53.339428, -6.257664) }

    describe '.generate_customers_to_invite' do
      it 'generates customers that are within the MAX_DISTANCE_FROM_OFFICE range' do
        obj.generate_customers_to_invite
        expect(obj.valid_customers.size).to eq(5)
        expect(obj.valid_customers.first).to be_a_kind_of(Dealer)
      end
    end

    describe '.customer_in_valid_distance?' do
      it 'returns true for distance less than a 100km' do
        expect(obj.send(:customer_in_valid_distance?, 50)).to eq(true)
      end

      it 'returns true for distance equals to a 100km' do
        expect(obj.send(:customer_in_valid_distance?, 100)).to eq(true)
      end

      it 'returns true for distance more than a 100km' do
        expect(obj.send(:customer_in_valid_distance?, 101)).to eq(false)
      end
    end

    describe '.convert_to_radians' do
      it 'converts a degree to a radian' do
        expect(obj.send(:convert_to_radians, 52.986375)).to eq(0.9247867024464104)
      end
    end

    describe '.distance_in_km' do
      it 'distance between a customer and the office that is less than 100km' do
        expect(obj.send(:distance_in_km, 53.2451022, -6.238335).to_i).to eq(10)
      end

      it 'distance between a customer and the office that is more than 100km' do
        expect(obj.send(:distance_in_km, 52.833502, -8.522366).to_i).to eq(161)
      end
    end
  end
end
