class CreateNotes < ActiveRecord::Migration[7.1]
  # rails generate Model Notes sender:references recipient:references{polymorphic} body:text
  def change
    create_table :notes do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :recipient, polymorphic: true, null: false
      t.text :body, null: false 

      t.timestamps
    end
  end
end
