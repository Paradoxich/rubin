class CreateBriefs < ActiveRecord::Migration[8.1]
  def change
    create_table :briefs do |t|
      t.string :title
      t.string :status
      t.text :body
      t.string :requester

      t.timestamps
    end
  end
end
