require 'rails_helper'

IMPORT_PRODUCTS_LINK_XPATH = "//li//a[contains(.,\"#{I18n.t('admin.import_products')}\")]"

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
  end
end
