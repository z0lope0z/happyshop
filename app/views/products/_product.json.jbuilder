json.extract! product, :id, :name, :sold_out, :category, :under_sale, :price, :sale_price, :created_at, :updated_at
json.url product_url(product, format: :json)
