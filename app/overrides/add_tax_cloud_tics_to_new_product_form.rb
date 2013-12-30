Deface::Override.new({
	virtual_path: "spree/admin/products/new",
	name: "add_tics_to_new_product",
	insert_bottom: ".row",
	text: %q{
		<div class="alpha four columns">
			<%= f.field_container :tax_cloud_tic do %>
				<%= f.label "Tax Cloud TIC" %><span class="required">*</span><br />
				<%= select(
					:product,
					:tax_cloud_tic, 
					@tax_cloud_tics.collect do |key, tic| 
						[ "#{tic.ticid}: #{tic.description}", tic.ticid ] 
					end, 
					{ prompt: true },
					{ class: "select2 fullwidth" }) %>
			<% end %>
		</div>
	}})
