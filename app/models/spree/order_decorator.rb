Spree::Order.class_eval do

  has_many :tax_cloud_transactions, :through => :shipment

  self.state_machine.after_transition :to => :payment, 
    :do => :lookup_tax_cloud, 
    :if => :tax_cloud_eligible?

  self.state_machine.after_transition :to => :complete, 
    :do => :capture_tax_cloud, 
    :if => :tax_cloud_eligible?



  def tax_cloud_eligible?
    ship_address.try(:state_id?)
  end



  def lookup_tax_cloud    
    shipments.each do |shipment|
      if shipment.tax_cloud_transaction.nil?
        shipment.tax_cloud_transaction = Spree::TaxCloudTransaction.new
        shipment.tax_cloud_transaction.lookup
        tax_cloud_adjustment shipment.tax_cloud_transaction
      else
        shipment.tax_cloud_transaction.lookup
      end 
    end    
  end



  def tax_cloud_adjustment tax_cloud_transaction
    adjustments.create do |adjustment|
      adjustment.source = self
      adjustment.originator = tax_cloud_transaction
      adjustment.label = "Tax"
      adjustment.mandatory = true
      adjustment.eligible = true
      adjustment.amount = tax_cloud_transaction.amount
    end
  end




  def promotions_total
    adjustments.promotion.map(&:amount).sum.abs
  end




  def capture_tax_cloud
    shipments.each do |ship|
      ship.tax_cloud_transaction.capture
    end
  end
end