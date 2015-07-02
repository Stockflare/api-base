class VariantController < Grape::API

  format :json
  get '/ping' do
    present({ hello: true })
  end

end
