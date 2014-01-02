TaxCloudForSpree::Engine.routes.draw do
end

Spree::Core::Engine.routes.draw do
	namespace :admin do
		resource :tax_cloud_settings
	end
end

