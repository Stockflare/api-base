ROM::SQL.migration do
  change do
    create_table :variants do

      primary_key :id

      String :name

    end
  end
end
