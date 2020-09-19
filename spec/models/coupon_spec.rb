require "rails_helper"

RSpec.describe Coupon, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :code }
    it { should validate_presence_of :percent_off }
    it { should validate_inclusion_of(:percent_off).in_range(0..100) }



  end
end
