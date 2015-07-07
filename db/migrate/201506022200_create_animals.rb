ROM::SQL.migration do
  change do
    create_table :animals do

      primary_key :id

      String :name, null: false

      Boolean :is_mammal, default: false

    end
  end
end
