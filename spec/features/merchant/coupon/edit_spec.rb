require "rails_helper"

RSpec.describe "Merchant Coupons", type: :feature do
  describe "As a merchant" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @user = @bike_shop.users.create(email: "c_j@email.com", password: "test", name: "Meg", city: "blah", state: "blah", address: "blah", zip: 12345, role: 1)
      @coupon = @bike_shop.coupons.create!(name: "Bulk Discount", code:"Bulk", percent_off: 20, quantity_requirement: 20)
      @coupon2 = @bike_shop.coupons.create!(name: "Holiday Sale", code:"Bulk", percent_off: 10, quantity_requirement: 20)
    end

    it "I can edit a coupon" do
      visit '/login'
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button "Login"
      click_on "My Coupons"

      within"#coupon-#{@coupon.id}" do
        expect(page).to have_link("Edit")
        click_on "Edit"
      end
      expect(current_path).to eq("/merchant/coupons/#{@coupon.id}/edit")

      fill_in 'Name', with: "Bulk"
      click_on "Update Coupon"
      expect(page).to have_content("Your coupon has been updated")
      expect(page).to have_content("Bulk")
      expect(current_path).to eq("/merchant/coupons")
    end

    it "I cannot edit a coupon and have empty fields" do
      visit '/login'
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button "Login"
      click_on "My Coupons"

      within"#coupon-#{@coupon.id}" do
        expect(page).to have_link("Edit")
        click_on "Edit"
      end
      expect(current_path).to eq("/merchant/coupons/#{@coupon.id}/edit")

      fill_in 'Name', with: ""
      click_on "Update Coupon"
      expect(page).to have_content("You are missing fields")
    end
  end
end
