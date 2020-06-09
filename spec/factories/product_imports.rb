FactoryBot.define do
  factory :product_import do
    products_csv_file { Rack::Test::UploadedFile.new('./spec/support/files/sample_csv_with_records.csv', 'text/csv') }

    before(:create) { |product_import| product_import.define_singleton_method(:create_products){} }
  end
end
