require 'rails_helper'

RSpec.describe ProductImport, type: :model do

  context 'validations' do
    context '#correct_document_mine_type' do
      context 'non CSV file attached' do
        let(:non_csv_file) { Rack::Test::UploadedFile.new('./spec/support/files/test_product.jpg', 'image/jpg') }
        let(:product_import) { build :product_import, products_csv_file:  non_csv_file }
        let(:product_csv_file_error_message) { product_import.errors.messages[:products_csv_file] }
        let(:expected_products_csv_error_message_arr) { [I18n.t('activerecord.attributes.product_import.products_csv_file')] }
        before { product_import.validate }

        it 'should not be valid' do
          expect(product_import.valid?).to be false
        end

        it 'should add proper validation error' do
          expect(product_csv_file_error_message).to match_array expected_products_csv_error_message_arr
        end
      end
    end
  end

  context 'callbacks' do
    let(:product_import) { build :product_import }
    before { product_import.save!  }

    context '#create_products' do
      it 'should enqueue CsvProductsWorker on after_commit' do
        expect(CsvProductsWorker).to have_enqueued_sidekiq_job(product_import.id)
      end
    end
  end

  context 'active storage' do

  end
end
