require 'rails_helper'

module Spree
  describe CsvProductsCreator, type: :service do
    describe '#call' do
      let(:product_import) { create :product_import }
      let(:product_import_id) { product_import.id }
      subject { described_class.call(product_import_id) }

      context 'when valid id passed' do
        let(:sample_shipping_category) { Spree::ShippingCategory.pluck(:name).sample }
        before { subject }

        it 'should properly create all products from a CSV file' do
          expect(Spree::Product.count).to eq 3
        end

        it 'should create new shipping categories when non existing' do
          expect(Spree::ShippingCategory.count).to eq 3
        end

        it 'all CSV values have stripped whitespaces' do
          expect(sample_shipping_category).not_to eq(" #{sample_shipping_category} ")
        end
      end

      context 'when wrong id passed' do
        let(:product_import_id) { (2**(0.size * 8 -2) -1) }

        it 'should raise an exception' do
            expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
