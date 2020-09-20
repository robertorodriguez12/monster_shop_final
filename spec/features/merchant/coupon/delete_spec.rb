require "rails_helper"

RSpec.describe "Merchant Coupons", type: :feature do
  describe "As a merchant" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @user = @bike_shop.users.create(email: "c_j@email.com", password: "test", name: "Meg", city: "blah", state: "blah", address: "blah", zip: 12345, role: 1)
      @coupon = @bike_shop.coupons.create!(name: "Bulk Discount", code:"Bulk", percent_off: 20, quantity_requirement: 20)
      @coupon2 = @bike_shop.coupons.create!(name: "Holiday Sale", code:"Bulk", percent_off: 10, quantity_requirement: 20)
    end

    it "I can delete a coupon" do
      visit '/login'
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button "Login"
      click_on "My Coupons"

      within"#coupon-#{@coupon2.id}" do
        expect(page).to have_link("Delete")
        click_on "Delete"
      end

      expect(current_path).to eq("/merchant/coupons")
      expect(page).to_not have_content(@coupon2.name)
      expect(page).to have_content("Coupon deleted")

    end
  end
end
