class Checkout

  def initialize(rules=[])
    @rules = rules
    @scanned_products = Hash.new
  end

  def scan(item)
    (@scanned_products.has_key? item) ? (@scanned_products[item] += 1) : (@scanned_products[item] = 1)
  end

  def total
    checkout_total = 0
    @scanned_products.each do |item, amount|
      rules = get_rules_for_product(item)

      while amount > 0
        rule = get_best_rule(rules, amount)
        checkout_total += rule.price
        amount -= rule.amount
      end

    end
    checkout_total
  end

  private

  def get_rules_for_product(product)
    @rules.select{ |rule| rule.product == product }.sort_by{ |r| r.amount }.reverse!
  end

  def get_best_rule(rules, amount)
    return rules.select{ |rule| rule.amount <= amount }.first
  end

end
