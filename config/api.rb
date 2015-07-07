class API < Grape::API

  mount AnimalController => '/'

end
