Spree::Shipment.class_eval do
	has_one :tax_cloud_transaction

	# a bit hacky. I need the line items that are only in this 
	# shipment, not in the entire order, and not the inventory units.
	# fingers crossed on this one!
	def line_items_strict
		line_items.select do |x| 
			inventory_units
				.uniq { |y| y.variant_id }
				.map { |z| z.variant_id }
				.include?(x.variant_id)
		end
	end

end