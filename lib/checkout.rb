require 'ostruct'

class Checkout
  def initialize(pricing_rules = Module.new, order = Order.new)
    @pricing_rules = pricing_rules
    @order = order
    order.extend(@pricing_rules)
  end

  def scan(item)
    @order << item.to_s
  end

  def total
    @order.calculate!
  end

  class Order
    def initialize(items = [], product_klass = Product)
      @items = items
      @product_klass = product_klass
    end

    def <<(item)
      @items << @product_klass.find_by_code(item)
    end

    def calculate!
      @items.reduce(0) { |total, item| total += item.price }
    end
  end

  class Product
    PRODUCTS = [
      { code: 'FR1', name: 'Fruit tea', price: 3.11 },
      { code: 'SR1', name: 'Strawberries', price: 5.00 },
      { code: 'CF1', name: 'Coffee', price: 11.23 }
    ]

    def self.find_by_code(code)
      product = PRODUCTS.find { |p| p[:code] == code } or
        raise ArgumentError, "Invalid product code supplied"
      OpenStruct.new(product)
    end
  end
end
