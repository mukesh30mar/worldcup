class CreateCoaches < ActiveRecord::Migration
  def self.up
    create_table :coaches do |t|
      t.column :name, :string, :limit => 50
      t.column :email, :string, :null => false
      t.column :encrypted_password, :string, :null => false
      t.column :activated_at, :datetime
      t.column :activation_code, :string
      t.column :team_name, :string, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :coaches
  end
end
