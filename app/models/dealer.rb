class Dealer < ApplicationRecord
  # == Constants ============================================================
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

  # == Instance Methods =====================================================
end
