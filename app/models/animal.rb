class Animal

  include ValueObject

  values do
    attribute :id, Integer
    attribute :name, String
    attribute :is_mammal, Boolean
  end

  def type
    if is_mammal
      :mammal
    else
      :not_a_mammal
    end
  end

  class Entity < AnimalEntity
  end

end
