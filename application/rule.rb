class Rule
  attr_accessor :product, :price, :amount

  def initialize(product, price, amount=1)
    @product = product
    @price = price
    @amount = amount
  end

end
