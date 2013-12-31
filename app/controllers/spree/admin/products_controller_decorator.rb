Spree::Admin::ProductsController.class_eval do

	protected 

		def load_data
			@tax_cloud_tics = tax_cloud.all_tics
			@taxons = Spree::Taxon.order(:name)
			@option_types = Spree::OptionType.order(:name)
			@tax_categories = Spree::TaxCategory.order(:name)
			@shipping_categories = Spree::ShippingCategory.order(:name)
		end


		def tax_cloud
			@tax_cloud ||= Spree::TaxCloud.new
		end

end