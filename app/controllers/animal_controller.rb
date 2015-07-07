class AnimalController < Grape::API

  helpers do
    def orm
      ROM.env
    end
  end

  format :json
  get '/' do
    orm.relations.animals.first
  end

end
