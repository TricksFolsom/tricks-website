class ChangeDiscontinueNoticeReasonFromStringToText < ActiveRecord::Migration[7.0]
  def change
    change_column :discontinue_notices, :reason, :text
  end
end
