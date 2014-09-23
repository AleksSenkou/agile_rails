require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  test "product price must be positive" do
  	product = Product.new(title: "Toltoy Anna Karenina",	
  												description: "novel",
  												image_url: "df.jpg")
  	product.price = -1
  	assert product.invalid?, "must be greater than or equal to 0.01"
  	product.errors[:price].join('; ')
  	product.price = 0
  	assert product.invalid?, "must be greater than or equal to 0.01"
  	product.errors[:price].join('; ')
  	product.price = 1
  	assert product.valid?, "azsd"
  end

  def new_product(image_url)
  	Product.new(title: "Toltoy Anna Karenina",
  							description: "novel",
  							image_url: "image_url",
  							price: 1)
  end

  test "image_url" do
  	ok = %w{ fred.png fred.gif fred.png FRED.JPG FRED.Jpg }
  	bad = %w{ fred.doc fred.gif/more gred.gif.more }

  	ok.each do |name|
  		assert new_product(name).valid?, "#{name} shouldn't be invalid"
  	end

  	bad.each do |name|
  		assert new_product(name).invalid?, "#{name} shouldn be valid"
  	end
  end

  test "name of product is unique" do
  	product = Product.new(title: "Sergey Esenin: 'Poems'",
  												description: "novefl",
  												image_url: "image_ufrl.jpg",
  												price: 1)
  	assert !product.save
  	assert_equal "has already been taken", product.errors[:title].join('; ')
  end
end
