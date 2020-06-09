class CsvProductsWorker
  include Sidekiq::Worker

  def perform(product_import_id)
    Spree::CsvProductsCreator.call(product_import_id)
  end
end
