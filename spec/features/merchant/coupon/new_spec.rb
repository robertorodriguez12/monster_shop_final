require "rails_helper"

RSpec.describe "Merchant Coupons", type: :feature do
  describe "As a merchant" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @user = @bike_shop.users.create(email: "c_j@email.com", password: "test", name: "Meg", city: "blah", state: "blah", address: "blah", zip: 12345, role: 1)
      @coupon = @bike_shop.coupons.create!(name: "Bulk Discount", code:"Bulk", percent_off: 5)
    end

    it "I can create new coupons" do
      visit '/login'
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button "Login"
      click_on "My Coupons"
      click_on "Create Coupon"

      expect(current_path).to eq('/merchant/coupons/new')

      fill_in 'Name', with: 'Holiday Sale'
      fill_in 'Code', with: 'HOLSALE'
      fill_in 'Percent off', with: 3
      click_on 'Create Coupon'

      expect(page).to have_content("Coupon Created")
      expect(current_path).to eq("/merchant/coupons")
    end

    it "cannot create a new coupon with missing fields" do
      visit '/login'
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button "Login"
      click_on "My Coupons"
      click_on "Create Coupon"

      expect(current_path).to eq('/merchant/coupons/new')

      fill_in 'Name', with: ""
      fill_in 'Code', with: 'HOLSALE'
      fill_in 'Percent off', with: 3
      click_on 'Create Coupon'

      expect(page).to have_content("You are missing required fields")

    end
  end
end
