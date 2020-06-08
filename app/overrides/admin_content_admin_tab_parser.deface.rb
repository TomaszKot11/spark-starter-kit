Deface::Override.new(
  :name => "admin_content_admin_tab_parser",
  :virtual_path => "spree/admin/shared/sub_menu/_product",
  :insert_bottom => "ul[data-hook='admin_product_sub_tabs'], #sidebar-product",
  :text => "<%= tab :products_import_new, label: :products_import_new %>"
)
