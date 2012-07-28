require 'minitest/autorun'
require_relative '../lib/checkout.rb'

module ExamplePricingRules; end

describe Checkout do
  it "can be instantiated" do
    Checkout.new
  end

  it "can be instantiated with pricing rules" do
    Checkout.new(ExamplePricingRules)
  end

  describe "#scan" do
    before do
      @order = MiniTest::Mock.new
      @order.expect :extend, nil, [ExamplePricingRules]
      @co = Checkout.new(ExamplePricingRules, @order)
    end

    it "creates and stores an Item" do
      item = 'XYZ'
      @order.expect :<<, nil, [item]
      @co.scan(item)
    end

    after do
      @order.verify
    end
  end
end
