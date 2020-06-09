require 'csv'

module Spree
  class CsvProductsCreator
    prepend Spree::ServiceModule:: Base

    def call(product_import_id)
      product_import = ProductImport.find(product_import_id)

      csv = CSV.parse(product_import.products_csv_file.download, headers: true)
      csv.each do |row|
        row_hash = row.to_h.each_value(&:strip!)
        # string to be consistent
        row_hash['shipping_category_id'] = Spree::ShippingCategory.find_or_create_by!(name: row_hash['shipping_category_name']).id
        row_hash.delete('shipping_category_name')
        Spree::Product.create!(row_hash)
      end
    end
  end
end
