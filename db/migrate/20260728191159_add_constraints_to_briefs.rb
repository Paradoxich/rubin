class AddConstraintsToBriefs < ActiveRecord::Migration[8.1]
  def change
    change_column_null :briefs, :title, false
    change_column_null :briefs, :requester, false
    change_column_null :briefs, :status, false
    change_column_default :briefs, :status, from: nil, to: "inbox"
    add_index :briefs, :status
  end
end
