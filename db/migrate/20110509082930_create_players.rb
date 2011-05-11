class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.column :coach_id, :integer
      t.column :type, :string, :null => false
      t.column :email, :string
      t.column :status, :boolean, :default => '0'
      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end
