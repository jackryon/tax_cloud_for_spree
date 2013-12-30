Deface::Override.new({
	virtual_path: "spree/admin/products/_form",
	name: "add tax cloud tics to product form",
	replace: "",
	text: %q{
		<%= f.field_container :tax_cloud_tic do %>
			<%= f.label "Tax Cloud TIC" %>
			<%= select(
				:product,
				:tax_cloud_tic, 
				@tax_cloud_tics.collect { |key, tic| 
					[ "#{tic.ticid}: #{tic.description}", tic.ticid ] }, 
				{ prompt: true },
				{ class: "select2" }) %>
		<% end %>
	}
})