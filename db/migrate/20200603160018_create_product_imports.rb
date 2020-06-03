class CreateProductImports < ActiveRecord::Migration[6.0]
  def change
    create_table :product_imports do |t|
      t.timestamps
    end
  end
end
