require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get "/products.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Product.count, data.length
  end

  test "show" do
    get "/products/#{Product.first.id}.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal ["id", "name", "price", "image_url", "description", "created_at", "updated_at"], data.keys
  end

  test "create" do
    assert_difference "Product.count", 1 do
      post "/products.json", params: { price: 1, name: "test product", description: "test description", image_url: "image.jpg" }
      data = JSON.parse(response.body)
      assert_response 200
      refute_nil data["id"]
      assert_equal "test product", data["name"]
      assert_equal 1, data["price"]
      assert_equal "image.jpg", data["image_url"]
      assert_equal "test description", data["description"]
    end
  end

  test "update" do
    product = Product.first
    patch "/products/#{product.id}.json", params: { name: "Updated name" }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal "Updated name", data["name"]
    assert_equal product.price, data["price"]
    assert_equal product.image_url, data["image_url"]
    assert_equal product.description, data["description"]
  end

  test "destroy" do
    assert_difference "Product.count", -1 do
      delete "/products/#{Product.first.id}.json"
      assert_response 200
    end
  end
end
