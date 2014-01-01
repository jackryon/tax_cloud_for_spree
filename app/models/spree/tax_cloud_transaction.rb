# Designed to be the Originator for an Adjustment on an order.

require_dependency "spree/order"

module Spree

	class TaxCloudTransaction < ActiveRecord::Base


		belongs_to :shipment
		validates_presence_of :shipment
		has_one :adjustment, :as => :originator
		has_one :order, :through => :shipment
		has_many :cart_items, 
			:class_name => "TaxCloudShipmentItem", 
			:dependent => :destroy




		# called when order updates adjustments
		def update_adjustment adjustment, source
			order = shipment.order
			rate = amount / order.item_total
			tax = (order.item_total - order.promotions_total) * rate
			tax = 0 if tax.nan?
			unless (adjustment.amount * 100).round == (tax * 100).round
				adjustment.update_column :amount, tax
			end
		end




		def lookup
			create_shipment_items
			response = tax_cloud.lookup(self)

			puts "TC response is"
			puts YAML::dump response

			if response.success?
				transaction do
					if response.body[:lookup_response][:lookup_result][:cart_items_response].blank?
						raise ::SpreeTaxCloud::Error, response.body[:lookup_response][:lookup_result][:messages][:response_message][:message]
					end
					response_shipment_items = Array.wrap(
						response.body[:lookup_response][:lookup_result][:cart_items_response][:cart_item_response])
					response_shipment_items.each do |response_shipment_item|
						shipment_item = shipment_items.find_by_index(
							response_shipment_item[:cart_item_index].to_i)
						shipment_item.update_attribute(
							:amount, response_shipment_item[:tax_amount].to_f)
					end
				end
			else
				raise ::SpreeTaxCloud::Error, 'TaxCloud response unsuccessful!'
			end
		end





		def capture
			puts "capture called!"
			tax_cloud.capture self
		end




		def amount
			shipment_items.map(&:amount).sum
		end





		private


		def shipment_price
			total = 0
			shipment_items.each do |item|
				total += ( item.price * item.quantity )
			end
			total
		end




		def tax_cloud
			@tax_cloud ||= Spree::TaxCloud.new
		end





		def create_cart_items
			if self.persisted?
				cart_items.delete_all
			end
			index = 0

			# inventory units for the shipment now, not the entire order!
			shipment.line_items_strict.each do |line_item|
				cart_items.create!({
					:index => (index += 1),
					:tic => line_item.variant.product.tax_cloud_tic,
					:sku => line_item.variant.sku.presence || line_item.variant.id,
					:quantity => line_item.quantity,
					:price => line_item.price.to_f,
					:line_item => line_item
				})

			end

			cart_items.create!({
				:index => (index += 1),
				:tic =>  Spree::Config.taxcloud_shipping_tic,
				:sku => "SHIPPING",
				:quantity => 1,
				:price => shipment.adjustment.amount
			})
		end

	end
end
