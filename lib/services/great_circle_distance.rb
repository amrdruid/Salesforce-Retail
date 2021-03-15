# frozen_string_literal: true

module Services
  # This class gets the distance between two points and checks if distance is valid
  # https://en.wikipedia.org/wiki/Great-circle_distance
  class GreatCircleDistance
    EARTH_MEAN_RADIUS_IN_KMS = 6371.009
    MAX_DISTANCE_FROM_CURRENT_LOCATION = 100

    attr_reader :all_customers, :valid_customers

    def initialize(customers_list, latitude, longitude)
      @all_customers = customers_list
      @latitude = latitude
      @longitude = longitude
    end

    def generate_customers_to_invite
      @valid_customers = @all_customers.select do |customer|
        customer_distance = distance_in_km(customer.latitude,
                                           customer.longitude)

        customer_in_valid_distance?(customer_distance)
      end
    end

    private

    def distance_in_km(customer_lat, customer_lng)
      Math.acos(
        Math.sin(convert_to_radians(customer_lat)) * Math.sin(convert_to_radians(@latitude)) +
        Math.cos(convert_to_radians(customer_lat)) * Math.cos(convert_to_radians(@latitude)) *
        Math.cos(convert_to_radians(@longitude - customer_lng))
      ) * EARTH_MEAN_RADIUS_IN_KMS
    end

    def customer_in_valid_distance?(distance)
      distance <= MAX_DISTANCE_FROM_CURRENT_LOCATION
    end

    def convert_to_radians(position)
      position * Math::PI / 180.0
    end
  end
end
