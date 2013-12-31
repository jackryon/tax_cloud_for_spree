class RenameSpreeTaxCloudCartItemToSpreeTaxCloudShipmentItem < ActiveRecord::Migration
  def change
  	rename_table :spree_tax_cloud_cart_items, :tax_cloud_shipment_items
  end
end
