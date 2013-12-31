$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tax_cloud_for_spree/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tax_cloud_for_spree"
  s.version     = TaxCloudForSpree::VERSION
  s.authors     = ["Jack Ryon"]
  s.email       = ["jackryon@gmail.com"]
  s.homepage    = ""
  s.summary     = "Summary of TaxCloudForSpree."
  s.description = "Description of TaxCloudForSpree."

  s.add_runtime_dependency "tax_cloud", "0.2.2"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

end
