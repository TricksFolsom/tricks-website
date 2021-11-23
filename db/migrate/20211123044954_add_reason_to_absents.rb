class AddReasonToAbsents < ActiveRecord::Migration[6.1]
  def change
    add_column :absents, :reason, :text, default: "N/A | Absent was submitted before 'Reason' was added to form."
  end
end
