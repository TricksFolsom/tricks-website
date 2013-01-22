class ChangeAgeFromIntegerToString < ActiveRecord::Migration
  def up
  	change_table :levels do |t|
  		t.change :age, :string
  	end
  end

  def down
  	change_table :levels do |t|
  		t.change :age, :integer
  	end
  end
end
