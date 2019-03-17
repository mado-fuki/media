class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :image
      t.references :post, foreign_key: true

      t.timestamps
    end
    add_index :images, [:post_id, :created_at]
  end
end