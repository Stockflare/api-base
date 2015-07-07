class AnimalRelation < ROM::Relation[Application::ORM]

  dataset :animals

  def mammals
    where(is_mammal: true)
  end

end
