require 'minitest/autorun'
require_relative '../lib/checkout.rb'

module ExamplePricingRules
  def adjust_prices!
    if hit_strawberry_threshold?
      @items.each do |item|
        if item.code == 'SR1'
          item.price = 4.50
        end
      end
    end
  end

  def calculate!
    adjust_prices!
    super
  end

  def hit_strawberry_threshold?
    @items.select { |item| item.code == 'SR1' }.count > 2
  end
end

describe Checkout do
  before do
    @pricing_rules = ExamplePricingRules
  end

  it "satisfies the first test data" do
    co = Checkout.new(@pricing_rules)
    [:FR1, :SR1, :FR1, :CF1].each { |item| co.scan(item) }
    assert_equal 22.45, co.total
  end

  it "satisfies the second test data" do
    co = Checkout.new(@pricing_rules)
    [:FR1, :FR1].each { |item| co.scan(item) }
    assert_equal 6.22, co.total
  end

  it "satisfies the third test data" do
    co = Checkout.new(@pricing_rules)
    [:SR1, :SR1, :FR1, :SR1].each { |item| co.scan(item) }
    assert_equal 16.61, co.total
  end
end
