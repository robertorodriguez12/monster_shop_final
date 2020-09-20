class Coupon < ApplicationRecord
  validates_presence_of :name, :code, :percent_off
  validates_presence_of :quantity_requirement, :allow_blank => true
  validates_inclusion_of :percent_off, in: (0..100)

  belongs_to :merchant

  def coupon_status
    status
    "Enabled"
  end

  def self.best_coupon(quantity)
    where('quantity_requirement <= ?', quantity).order(percent_off: :desc).pluck(:percent_off).first
  end

end
