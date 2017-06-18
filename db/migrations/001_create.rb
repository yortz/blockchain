Sequel.migration do
  change do
    create_table :accounts do
      primary_key :id
      column :address, :varchar
      column :balance, :integer
    end
  end
end
