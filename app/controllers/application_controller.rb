class ApplicationController < Sinatra::Base
  set default_content_type: 'application/json'

  get '/bakeries' do
    bakeries = Bakery.all
    bakeries.to_json
  end

  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    bakery.to_json(include: :baked_goods)
  end

  get '/baked_goods' do
    BakedGood.all.to_json
  end

  get '/baked_goods/by_price' do
    # see the BakedGood class for the  method definition of `.by_price`
    baked_goods = BakedGood.by_price
    baked_goods.to_json
  end

  get '/baked_goods/most_expensive' do
    # see the BakedGood class for the  method definition of `.by_price`
    baked_good = BakedGood.by_price.first
    baked_good.to_json
  end

  post '/baked_goods' do
    BakedGood.create(
      name: params[:name],
      price: params[:price],
      bakery_id: params[:bakery_id]
    ).to_json
  end

  patch '/bakeries/:id' do
    # find bakery by id
    selected_bakery = Bakery.find(params[:id])

    # update selected bakery

    selected_bakery.update(
      name: params[:name]
    )

    # parse update as json and return

    selected_bakery.to_json
  end

  delete '/baked_goods/:id' do
    baked_good_to_be_deleted = BakedGood.find(params[:id])

    baked_good_to_be_deleted.destroy

    baked_good_to_be_deleted.to_json
  end
end
