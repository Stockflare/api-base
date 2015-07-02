class API < Grape::API

  # mount FooController => '/foo'

  mount VariantController => '/'

end
