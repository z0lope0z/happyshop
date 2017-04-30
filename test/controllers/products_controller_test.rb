require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  # http://localhost:3000/products?filter[category]=juice&filter[price]=100

  # http://localhost:3000/products?filter[category]=juice&sort=-price&?page%5Bnumber%5D=1&page%5Bsize%5D=1
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: { category: @product.category, name: @product.name, price: @product.price, sale_price: @product.sale_price, sold_out: @product.sold_out, under_sale: @product.under_sale }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: { category: @product.category, name: @product.name, price: @product.price, sale_price: @product.sale_price, sold_out: @product.sold_out, under_sale: @product.under_sale }
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
