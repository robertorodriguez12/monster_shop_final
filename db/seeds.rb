# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


@megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
@brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
@user = @megan.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'merchant@merchant.com', password: 'test', role: 1)
@user = @brian.users.create(name: 'Brian', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'merchant1@merchant.com', password: 'test', role: 1)
@megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 10 )
@megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 10 )
@brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 10 )
@coupon = @megan.coupons.create!(name: "Bulk Discount", code:"Bulk", percent_off: 20, quantity_requirement: 10)
@coupon2 = @megan.coupons.create!(name: "Holiday Sale", code:"Bulk", percent_off: 10, quantity_requirement: 5)
@coupon3 = @brian.coupons.create!(name: "Bulk Discount", code:"Bulk", percent_off: 20, quantity_requirement: 10)
@coupon4 = @brian.coupons.create!(name: "Holiday Sale", code:"Bulk", percent_off: 10, quantity_requirement: 5)
