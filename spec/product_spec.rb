require 'minitest/autorun'
require_relative '../lib/checkout.rb'

describe Checkout::Product do
  describe ".find_by_code" do
    it "can find each of the three products" do
      ['FR1', 'SR1', 'CF1'].each do |code|
        Checkout::Product.find_by_code(code).wont_be_nil
      end
    end

    it "throws an error if an invalid code is submitted" do
      lambda { Checkout::Product.find_by_code 'bogus' }.must_raise(ArgumentError)
    end
  end
end
