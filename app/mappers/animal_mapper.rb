class AnimalMapper < ROM::Mapper

  relation :animals

  register_as :animal

  model Animal

end
