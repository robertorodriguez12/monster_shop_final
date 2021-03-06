class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || {}
    @contents.default = 0
  end

  def add_item(item_id)
    @contents[item_id] += 1
  end

  def less_item(item_id)
    @contents[item_id] -= 1
  end

  def count
    @contents.values.sum
  end

  def items
    @contents.map do |item_id, _|
      Item.find(item_id)
    end
  end

  def grand_total
    grand_total = 0.0
    @contents.each do |item_id, quantity|
      grand_total += Item.find(item_id).price * quantity
    end
    grand_total
  end

  def count_of(item_id)
    @contents[item_id.to_s]
  end

  def subtotal_of(item_id)
    @contents[item_id.to_s] * Item.find(item_id).price
  end


  def limit_reached?(item_id)
    count_of(item_id) == Item.find(item_id).inventory
  end

  def is_coupon?(all_coupons, item_id)
    all_coupons.any? do |coup| # => Rework this method to get rid of the ruby language and only use active record.
      coup.quantity_requirement <= count_of(item_id)
    end
  end

  def discounted_subtotal(item_id, coupon)
    total = @contents[item_id.to_s] * Item.find(item_id).discounted_price(coupon)
    total.round(2)
  end

end
