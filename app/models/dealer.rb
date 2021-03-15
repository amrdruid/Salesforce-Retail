class Dealer < ApplicationRecord
  # == Constants ============================================================
  # TODO: When categories grows bigger than 1, move to an enum
  CATEGORIES = {
    point_of_sale: 'Dealer and Point of Sale'
  }.freeze

  # == Relationships ========================================================
  has_one :contact_info

  accepts_nested_attributes_for :contact_info
  # == Validations ==========================================================
  validates_presence_of :name, :sf_id, :category

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================
  def self.within_range(dealers:, latitude:, longitude:)
    great_circle_distance = Services::GreatCircleDistance.new(dealers, latitude, longitude)
    great_circle_distance.generate_customers_to_invite
  end

  # == Instance Methods =====================================================
end
