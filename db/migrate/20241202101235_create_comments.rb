class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :text
      t.references :ticket, null: false, foreign_key: true
      t.references :author, index: true,
        foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
