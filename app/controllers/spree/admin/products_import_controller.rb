module Spree
    module Admin
        class ProductsImportController < Spree::Admin::BaseController
            def new
                @product_import = ProductImport.new
            end

            def create
                product = ProductImport.new(product_import_params)
                if product.save
                    redirect_to :admin_products, notice: I18n.t('admin.products.after_csv_upload')
                else
                    redirect_to :admin_products_import_new, notice: product.errors[:products_csv_file].first
                end
            end

            private

            def product_import_params
                params.require(:product_import).permit(:products_csv_file)
            end
        end
    end
end
