class AddTaxCloudTicToProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :tax_cloud_tic, :integer
  end
end
