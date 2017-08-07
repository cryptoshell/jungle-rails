require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "should validate all fields" do
      @category = Category.create name: "Kitchen"
      @product = Product.create name: "Mixer", price: 20, quantity: 10, category: @category
      expect(@product).to be_valid
    end

    it "should validate name" do
      @category = Category.create name: "Kitchen"
      @product = Product.create name: nil, price: 20, quantity: 10, category: @category
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:name]).to include("can't be blank")
    end

    it "should validate price" do
      @category = Category.create name: "Kitchen"
      @product = Product.create name: 'mixer', price: nil, quantity: 10, category: @category
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:price]).to include("can't be blank")
    end

    it "should validate quantity" do
      @category = Category.create name: "Kitchen"
      @product = Product.create name: 'mixer', price: 100, quantity: nil, category: @category
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:quantity]).to include("can't be blank")
    end

     it "should validate category" do
      @product = Product.create name: 'mixer', price: 100, quantity: 10, category: nil
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:category]).to include("can't be blank")
    end
  end
end