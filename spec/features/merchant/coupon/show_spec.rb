require "rails_helper"

RSpec.describe "Merchant Coupons", type: :feature do
  describe "As a merchant" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @user = @bike_shop.users.create(email: "c_j@email.com", password: "test", name: "Meg", city: "blah", state: "blah", address: "blah", zip: 12345, role: 1)
      @coupon = @bike_shop.coupons.create!(name: "Bulk Discount", code:"Bulk", percent_off: 20)
      @coupon2 = @bike_shop.coupons.create!(name: "Holiday Sale", code:"Bulk", percent_off: 10)
    end

    it "I can visit a coupons show page" do
      visit '/login'
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button "Login"
      click_on "My Coupons"

      within"#coupon-#{@coupon.id}" do
        click_on "#{@coupon.name}"
      end

      expect(current_path).to eq("/merchant/coupons/#{@coupon.id}")
      expect(page).to have_content(@coupon.name)
      expect(page).to have_content(@coupon.code)
      expect(page).to have_content(@coupon.percent_off)
      expect(page).to have_content("Enabled")

    end

  end
end
