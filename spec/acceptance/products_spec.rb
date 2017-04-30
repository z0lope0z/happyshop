require 'acceptance_helper'

resource 'Products' do
  header 'Accept', 'application/vnd.api+json'
  header 'Content-Type', 'application/json'

  let!(:water) do
    Product.create(name: 'water', category: 'water', price: 200)
  end
  let!(:orange_juice) do
    Product.create(name: 'orange juice', category: 'juice', price: 100)
  end
  let!(:grape_juice) do
    Product.create(name: 'grape juice', category: 'juice', price: 300)
  end

  get '/products' do
    parameter 'filter[id]'.to_sym, 'Get product by ID'
    parameter 'filter[category]'.to_sym, 'Filter by category or price'
    parameter :sort, 'Sort by price'
    parameter 'page[number]'.to_sym, 'Page number'
    parameter 'page[size]'.to_sym, 'Items in a given page'

    example_request 'Getting a single product' do
      do_request('filter[id]'.to_sym => water.id)
      response = JSON.parse(response_body)
      expect(response['data'].first['id']).to eq(water.id.to_s)
      expect(response['data'].size).to eq(1)
      expect(status).to eq(200)
    end

    example_request 'Getting a list of products' do
      do_request
      response = JSON.parse(response_body)
      expect(response['data'].size).to eq(3)
      expect(status).to eq(200)
    end

    example_request 'Paginate products' do
      do_request(
        'page[number]'.to_sym => '2',
        'page[size]'.to_sym => '1'
      )
      response = JSON.parse(response_body)
      expect(response['data'].size).to eq(1)
      expect(response['links']['first']).not_to be_nil
      expect(response['links']['last']).not_to be_nil
      expect(status).to eq(200)
    end

    example_request 'Filter by category and sort price in descending order' do
      do_request(
        'filter[category]'.to_sym => 'juice',
        sort: '-price'
      )
      response = JSON.parse(response_body)
      expect(response['data'].size).to eq(2)
      expect(response['data'].first['id']).to eq(grape_juice.id.to_s)
      expect(status).to eq(200)
    end
  end
end
