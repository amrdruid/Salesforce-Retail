class ContactInfo < ApplicationRecord
  # == Constants ============================================================

  # == Relationships ========================================================

  # TODO: Move to polymorphic association if we had other entites with contact info
  belongs_to :dealer

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

end
