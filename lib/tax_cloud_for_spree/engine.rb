module TaxCloudForSpree
  class Engine < ::Rails::Engine
    isolate_namespace Spree
  end
end
