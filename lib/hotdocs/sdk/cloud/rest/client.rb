# lib/hotdocs/sdk/cloud/rest/rest_client.rb
require 'open-uri'
require 'rest_client'

module Hotdocs
  module Sdk
    module Cloud
      module Rest

        #
        # The RESTful implementation of the Core Services client.
        #
        class Client < ClientBase
          include ClientSession

          attr_accessor :OutputDir, :subscriberID, :signingKey

          DEFAULT_OUTPUT_DIR = ""

          class << self
            attr_accessor :subscriberID, :signingKey

            def method_missing(sym, *args, &block)
              new(subscriberID, signingKey).send(sym, *args, &block)
            end
          end

          #
          # Constructs a Client object.
          #
          def initialize subscriberID = nil, signingKey = nil, outputDir = nil, hostAddress = nil, proxyServerAddress = nil
            subscriberID ||= self.class.subscriberID || ENV['HOTDOCS_SUBSCRIBER_ID']
            signingKey ||= self.class.signingKey || ENV['HOTDOCS_SIGNINGKEY']
            super(subscriberID.dup, signingKey.dup, hostAddress, "", proxyServerAddress)
            @OutputDir = outputDir || DEFAULT_OUTPUT_DIR
          end

          #
          # Uploads a package to HotDocs Cloud Services. Since this method throws an exception if the package already exists in the
          # HotDocs Cloud Services cache, only call it when necessary.
          #
          # Parameters:
          #  - packageID:
          #  - billingRef:
          #  - packageFile: The file name and path of the package file to be uploaded.
          def UploadPackage packageID, billingRef, packageFile
            packageStream = !packageFile.blank? && File.exists?(packageFile) ? File.new(packageFile, "r") : nil
            UploadPackageStream(packageID, billingRef, packageStream)
            packageStream.close if packageStream
          end

          #
          # Uploads a package to HotDocs Cloud Services. Since this method throws an exception if the package already exists in the
          # HotDocs Cloud Services cache, only call it when necessary.
          #
          # Parameters:
          #  - packageID:
          #  - billingRef:
          #  - packageStream: A stream containing the package to upload.
          # http://help.hotdocs.com/cloudservices/WSRef_Direct/api_uploadpackage.htm
          # PUT https://cloud.hotdocs.ws/hdcs/{subscriberID}/{packageID}
          def UploadPackageStream packageID, billingRef, packageStream
            utcNow = DateTime.now
            paramList = [ utcNow, @SubscriberID, packageID, nil, true, billingRef ]
            hmac = Server::Contracts::HMAC.CalculateHMAC(@SigningKey, paramList)
            urlBuilder = [ @EndpointAddress, "/RestfulSvc.svc/", @SubscriberID, "/", packageID ].join

            if !billingRef.blank?
              urlBuilder += "?billingRef=" + billingRef
            end

            resource = ::RestClient::Resource.new( URI::encode(urlBuilder),
              :headers => {
                :content_type => "application/binary",
                :"x-hd-date" => utcNow.utc,
                :Authorization => hmac
              }
            )

            if !@ProxyServerAddress.blank?
              ::RestClient.proxy = @ProxyServerAddress
            end

            bytes = packageStream ? packageStream.read : nil
            response = resource.put(bytes) { |response, request, result| result }
            response.body
          end

          protected
            #
            #
            # Parameters:
            #  - func: A function passed as a Proc
            #
            # Raise the following error if package are still missing after upload:
            #   "HotDocs.Cloud.Storage.PackageNotFoundException: Package \"template_x_xxxxxxxxxx\" belonging to subscriber \"xxxxxxxx\" cannot be found."
            #   the calling method has to manage rescue.
            #   Ex: CreateSession return nil instead of an invalid string
            def TryWithoutAndWithPackage &func
              response = func.call(false)

              if response.include?("HotDocs.Cloud.Storage.PackageNotFoundException")
                response = func.call(true)
                raise Storage::PackageNotFoundException, response if response.include?("HotDocs.Cloud.Storage.PackageNotFoundException")
              elsif response.include?("HotDocs.Cloud.EmbeddedSvc.ResumeSession")
                raise Storage::EmptyResumeSessionAnswerException, response
              end

              response

              # rescue => response # WIP - Network error
              #  puts "Error code: {#{response.code}}"
              #  raise response if !response.include?("cannot be found")
            end

            #
            #
            #
            # Parameters:
            #  - template:
            #  - answers:
            #  - settings:
            #  - billingRef:
            #  - uploadPackage:
            #
            # Parameters are different than SDK to match CreateSessionImpl
            def AssembleDocumentImpl template, answers, outputFormat, settings, billingRef, uploadPackage
              # if !(template.Location.is_a?(PackageTemplateLocation))
              #   raise "HotDocs Cloud Services requires the use of template packages. Please use a PackageTemplateLocation derivative."
              # end
              # packageTemplateLocation = template.Location

              packageID = template.packageID
              packageFile = template.file_url
              packageFilename = template.file.filename #FileName

              if uploadPackage
                UploadPackage(packageID, billingRef, packageFile)
              end

              timestamp = DateTime.now

              paramList = [ timestamp, @SubscriberID, packageID, packageFilename, false, billingRef, outputFormat, settings ]
              hmac = Server::Contracts::HMAC.CalculateHMAC(@SigningKey, paramList)

              urlBuilder = [ @EndpointAddress, "/RestfulSvc.svc/assemble/", @SubscriberID, "/", packageID, "/", packageFilename || "", "?format=", interviewFormat.to_s ].join

              if !billingRef.blank?
                urlBuilder += "&billingref=" + billingRef
              end

              if settings
                settings.each do |k, v|
                  urlBuilder += "&#{k.to_s}=#{v || ''}"
                end
              end

              p urlBuilder

              resource = ::RestClient::Resource.new( URI::encode(urlBuilder),
                :headers => {
                  :content_type => "text/xml",
                  :"x-hd-date" => timestamp.utc,
                  :Authorization => hmac,
                  :content_length => answers ? answers.size : 0
                }
              )

              if !@ProxyServerAddress.blank?
                ::RestClient.proxy = @ProxyServerAddress
              end

              bytes = answers ? answers.force_encoding("UTF-8") : nil
              response = resource.post(bytes) do |response, request, result|
                p response
                result
              end

              response.body

              FileUtils.mkdir_p( @OutputDir ) unless File.exists?(@OutputDir)
              raise "Stop"
            end

        end

      end
    end
  end
end

    # protected internal override AssemblyResult AssembleDocumentImpl(
    # {

    #   using (var resultsStream = new MemoryStream())
    #   {
    #     // Each part is written to a file named after the Content-ID value,
    #     // except for the AssemblyResult part, which has a Content-ID of "XML0",
    #     // and is parsed into an AssemblyResult object.
    #     _parser.WritePartsToStreams(
    #       response.GetResponseStream(),
    #       h =>
    #       {
    #         string id;
    #         if (h.TryGetValue("Content-ID", out id))
    #         {
    #           // Remove angle brackets if present
    #           if (id.StartsWith("<") && id.EndsWith(">"))
    #           {
    #             id = id.Substring(1, id.Length - 2);
    #           }

    #           if (id.Equals("XML0", StringComparison.OrdinalIgnoreCase))
    #           {
    #             return resultsStream;
    #           }

    #           return new FileStream(Path.Combine(OutputDir, id), FileMode.Create);
    #         }
    #         return Stream.Null;
    #       },
    #       (new ContentType(response.ContentType)).Boundary);

    #     if (resultsStream.Position > 0)
    #     {
    #       resultsStream.Position = 0;
    #       var serializer = new XmlSerializer(typeof(AssemblyResult));
    #       return (AssemblyResult)serializer.Deserialize(resultsStream);
    #     }
    #     return null;
    #   }
    # }
