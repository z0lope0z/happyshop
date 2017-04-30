class ProductResource < JSONAPI::Resource
  attributes :name, :sold_out, :category, :under_sale, :price, :sale_price

  filters :id, :category, :price

  def self.sortable_fields(context)
    super(context) - [:name, :sold_out, :category, :under_sale, :sale_price]
  end
end
