class ProductImport < ApplicationRecord
    has_one_attached :products_csv_file

    validate :correct_document_mime_type

    private

    def correct_document_mime_type
      if products_csv_file.attached? && !products_csv_file.content_type.in?(%w(text/csv))
        errors.add(:products_csv_file, I18n.t('activerecord.attributes.product_import.products_csv_file'))
      end
    end
end
