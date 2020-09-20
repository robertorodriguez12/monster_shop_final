require "rails_helper"

RSpec.describe Coupon, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :code }
    it { should validate_presence_of :percent_off }
    it { should allow_value("", nil).for(:quantity_requirement) }
    it { should validate_inclusion_of(:percent_off).in_range(0..100) }

  end

  describe "methods" do
        before :each do
            @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
            @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
            @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
            @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 12 )
            @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 30 )
            @coupon = @megan.coupons.create(name: "bulk", code: "123", percent_off: 2, quantity_requirement: 5)
            @coupon2 = @megan.coupons.create(name: "bulk", code: "234", percent_off: 5, quantity_requirement: 10)
            @coupon3 = @megan.coupons.create(name: "bulk", code: "456", percent_off: 10, quantity_requirement: 20)


          end
          it '.best_coupon(quantity)' do
             bulk_discount = @megan.coupons.best_coupon(11)
             bulk_discount2 = @megan.coupons.best_coupon(4)
             bulk_discount3 = @megan.coupons.best_coupon(6)
             bulk_discount4 = @megan.coupons.best_coupon(30)

             expect(bulk_discount).to eq(5)
             expect(bulk_discount2).to eq(nil)
             expect(bulk_discount3).to eq(2)
             expect(bulk_discount4).to eq(10)
           end
           it "Can display a status of enabled if status is true" do
             expect(@coupon.coupon_status).to eq("Enabled")
           end

    end

end
