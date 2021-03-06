require "rails_helper"

RSpec.describe "Merchant Coupons", type: :feature do
  describe "As a merchant" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @user = @bike_shop.users.create(email: "c_j@email.com", password: "test", name: "Meg", city: "blah", state: "blah", address: "blah", zip: 12345, role: 1)
      @coupon = @bike_shop.coupons.create!(name: "Bulk Discount", code:"Bulk", percent_off: 5, quantity_requirement: 20)
    end

    it "I can see a list of all my coupons" do
      visit '/login'
      expect(current_path).to eq("/login")

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button "Login"

      visit '/merchant'
      expect(page).to have_link("My Coupons")
      click_on "My Coupons"
      expect(current_path).to eq('/merchant/coupons')
      expect(page).to have_content(@coupon.name)
      expect(page).to have_content(@coupon.code)
      expect(page).to have_content(@coupon.percent_off)
    end

    it "I can see a link to create a new coupon" do
      visit '/login'
      expect(current_path).to eq("/login")

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button "Login"
      click_on "My Coupons"

      expect(page).to have_link("Create Coupon")
    end

  end
end
