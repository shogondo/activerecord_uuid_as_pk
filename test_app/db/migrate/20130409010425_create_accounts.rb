class CreateAccounts < ActiveRecord::Migration
  def up
    create_table :accounts, :id => false do |t|
      t.binary :uuid, :limit => 16
      t.string :name
    end
  end

  def down
    drop_table :accounts
  end
end
