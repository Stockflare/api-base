describe VariantController, type: :controller do

  before { get '/foo/ping' }

  specify { expect_json_types({ bar: :string }) }

  specify { expect_json({ bar: "hello" }) }

end
