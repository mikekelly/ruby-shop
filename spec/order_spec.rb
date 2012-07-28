require 'minitest/autorun'
require_relative '../lib/checkout.rb'

describe Checkout::Order do
  it "can be instantiated" do
    Checkout::Order.new
  end

  describe "#<<" do
    before do
      @items = MiniTest::Mock.new
      @product_klass = MiniTest::Mock.new
    end

    it "stores items pushed in with a code" do
      @order = Checkout::Order.new(@items, @product_klass)

      item_code = 'XYZ'
      item = OpenStruct.new

      @product_klass.expect :find_by_code, item, [item_code]
      @items.expect :<<, nil, [item]

      @order << item_code
    end

    after do
      @product_klass.verify
      @items.verify
    end
  end

  describe "#calculate" do
    before do
      @items = []
      3.times do
        @items << OpenStruct.new({ price: 10.00 })
      end
      @co = Checkout::Order.new(@items)
    end

    it "calculates a price" do
      result = @co.calculate!
      assert_equal 30, result
    end
  end
end
