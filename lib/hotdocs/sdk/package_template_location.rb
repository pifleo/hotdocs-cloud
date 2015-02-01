# lib/hotdocs/sdk/package_template_location.rb

module Hotdocs
  module Sdk
    module Cloud

      #
      # PackageTemplateLocation is the base class representing all template locations where
      # the template resides in a package. This class provides access to the package ID, the package
      # manifest, and the package itself.
      #
      class PackageTemplateLocation # < TemplateLocation

        # Returns the package ID.
        attr_reader :PackageID

        #
        # Construct a PackageTemplateLocation object representing a package with the specified ID.
        #
        # Parameters:
        #  - packageID: The ID of the package.
        def initialize packageID
          raise "Invalid argument" if packageID.blank?
          @PackageID = packageID
        end
      end

    end
  end
end

