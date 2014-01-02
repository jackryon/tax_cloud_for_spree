class ChangeSpreeTaxCloudTransactionsOrderIdToShipmentId < ActiveRecord::Migration
  def change
  	rename_column :spree_tax_cloud_transactions, :order_id, :shipment_id
  end
end
