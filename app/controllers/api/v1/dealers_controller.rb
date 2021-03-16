class Api::V1::DealersController < ApplicationController
  # TODO: Add authroization for only internal users with permissions to trigger this endpoint
  # There is a rake task that does the same job
  def add_point_of_sales_dealers
    AddDealersWorker.perform_async

    # TODO: Make the message part of the I18n of the application
    render json: 'Point of Sales Dealers will be added to the database in few minutes', status: :created
  end

  # We filter dealers based on how far they are from the current lng and lat
  # Pagination is done based on GreatCircleDistance
  # Dealers that are on a distance of 100km or less from the current lat and lng are a valid response
  def dealers_within_range
    # TODO: Cache the Dealer.all and refresh the cache when a new dealer is added
    # TODO: See if it is possible to cache the dealers based on the lng and lat sent. Refresh this cache at ....
    # ... specific time span and add to it if a new dealer is added
    dealers_within_range = Dealer.within_range(dealers: Dealer.all,
                                               latitude: params[:latitude],
                                               longitude: params[:longitude])

    render json: DealerSerializer.new(dealers_within_range).serializable_hash, status: :ok
  end
end
