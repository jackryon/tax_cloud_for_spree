Deface::Override.new({	
	virtual_path: "spree/admin/products/_form",
	name: "add tax cloud tics to product form",
	replace: "[data-hook='admin_product_form_right']",
	text: %q{

<div class="right four columns omega" data-hook="admin_product_form_right">
    <%= f.field_container :price do %>
      <%= f.label :price, raw(Spree.t(:master_price) + content_tag(:span, ' *', :class => "required")) %>
      <%= f.text_field :price, :value => number_to_currency(@product.price, :unit => '') %>
      <%= f.error_message_on :price %>
    <% end %>

    <div class="alpha two columns">
      <%= f.field_container :cost_price do %>
        <%= f.label :cost_price, Spree.t(:cost_price) %>
        <%= f.text_field :cost_price, :value => number_to_currency(@product.cost_price, :unit => '') %>
        <%= f.error_message_on :cost_price %>
      <% end %>
    </div>
    <div class="omega two columns">
      <%= f.field_container :cost_currency do %>
        <%= f.label :cost_currency, Spree.t(:cost_currency) %>
        <%= f.text_field :cost_currency %>
        <%= f.error_message_on :cost_currency %>
      <% end %>
    </div>

    <div class="clear"></div>

    <%= f.field_container :available_on do %>
      <%= f.label :available_on, Spree.t(:available_on) %>
      <%= f.error_message_on :available_on %>
      <%= f.text_field :available_on, :value => datepicker_field_value(@product.available_on), :class => 'datepicker' %>
    <% end %>

    <% unless @product.has_variants? %>
      <%= f.field_container :sku do %>
        <%= f.label :sku, Spree.t(:sku) %>
        <%= f.text_field :sku, :size => 16 %>
      <% end %>

      <ul id="shipping_specs">
        <li id="shipping_specs_weight_field" class="field alpha two columns">
          <%= f.label :weight, Spree.t(:weight) %>
          <%= f.text_field :weight, :size => 4 %>
        </li>
        <li id="shipping_specs_height_field" class="field omega two columns">
          <%= f.label :height, Spree.t(:height) %>
          <%= f.text_field :height, :size => 4 %>
        </li>
        <li id="shipping_specs_width_field" class="field alpha two columns">
          <%= f.label :width, Spree.t(:width) %>
          <%= f.text_field :width, :size => 4 %>
        </li>
        <li id="shipping_specs_depth_field" class="field omega two columns">
          <%= f.label :depth, Spree.t(:depth) %>
          <%= f.text_field :depth, :size => 4 %>
        </li>
      </ul>
    <% end %>

    <%= f.field_container :shipping_categories do %>
      <%= f.label :shipping_category_id, Spree.t(:shipping_categories) %>
      <%= f.collection_select(:shipping_category_id, @shipping_categories, :id, :name, { :include_blank => Spree.t('match_choices.none') }, { :class => 'select2' }) %>
      <%= f.error_message_on :shipping_category %>
    <% end %>

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
</div>
	}	
})
