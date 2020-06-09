require 'rails_helper'

IMPORT_PRODUCTS_LINK_XPATH = "//li//a[contains(.,\"#{I18n.t('spree.admin.tab.products_import_new')}\")]"

RSpec.describe 'admin import products page' do
  let(:user) { FactoryBot.create(:admin_user) }

  before(:each) do
    login_as(user, scope: :spree_user)
  end

  it 'returns 200 HTTP status' do
    visit '/admin/products_import/new'
    expect(page).to have_http_status('200')
  end

  it 'Import prodcuts list item should be present in the DOM' do
    visit '/admin'
    expect(page).to have_xpath(IMPORT_PRODUCTS_LINK_XPATH)
  end

  context 'Import Button clicked' do
    before(:each) do
      visit '/admin'
      find(:xpath, IMPORT_PRODUCTS_LINK_XPATH).click
    end

    it "After 'Import Products' link click valid page should be displayed" do
      expect(page).to have_text I18n.t('admin.import_page.title')
    end

    context 'file upload' do
      it 'appropriate file button should be present' do
        expect(page).to have_selector('#product_import_products_csv_file')
      end

      it 'file upload should be possible by button' do
        expect(page).to have_selector(:link_or_button, I18n.t('admin.import_page.submit_btn'))
      end

      context 'after CSV file submit' do
        before :each do
          visit '/admin/products_import/new'
          page.attach_file('product_import_products_csv_file', './spec/support/files/sample.csv')
          page.find('input[value="Upload"]').click
        end

        it 'user is redirected' do
          expect(page.current_path).to eq '/admin/products'
        end

        it 'should create appropriate record' do
          expect(ProductImport.count).to eq 1
        end

        it 'after redirection proper flash message is displayed' do
          expect(page).to have_text I18n.t('admin.products.after_csv_upload')
        end
      end

      context 'after non CSV file submit' do
        before :each do
          visit '/admin/products_import/new'
          page.attach_file('product_import_products_csv_file', './spec/support/files/test_product.jpg')
          page.find('input[value="Upload"]').click
        end

        it 'should display proper alert' do
          expect(page).to have_text I18n.t('activerecord.attributes.product_import.products_csv_file')
        end
      end
    end
  end
end
