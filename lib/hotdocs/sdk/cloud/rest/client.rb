# lib/hotdocs/sdk/cloud/rest/client.rb
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

          attr_accessor :outputDir, :subscriberID, :signingKey

          DEFAULT_OUTPUT_DIR = Dir.tmpdir

          class << self
            attr_accessor :subscriberID, :signingKey

            def method_missing(sym, *args, &block)
              new(subscriberID, signingKey).send(sym, *args, &block)
            end
          end

          #
          # Constructs a Client object.
          #
          def initialize subscriberID = nil, signingKey = nil, outputDirParam = nil, hostAddress = nil, proxyServerAddress = nil
            subscriberID ||= self.class.subscriberID || ENV['HOTDOCS_SUBSCRIBER_ID']
            signingKey ||= self.class.signingKey || ENV['HOTDOCS_SIGNINGKEY']
            super(subscriberID.dup, signingKey.dup, hostAddress, 'RestfulSvc.svc', proxyServerAddress)
            @outputDir = outputDirParam || DEFAULT_OUTPUT_DIR
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
          #
          # http://help.hotdocs.com/cloudservices/WSRef_Direct/api_uploadpackage.htm
          # PUT https://cloud.hotdocs.ws/hdcs/{subscriberID}/{packageID}
          def UploadPackageStream packageID, billingRef, packageStream
            utcNow = DateTime.now
            paramList = [ utcNow, @SubscriberID, packageID, nil, true, billingRef ]
            hmac = Server::Contracts::HMAC.CalculateHMAC(@SigningKey, paramList)
            urlBuilder = File.join( @EndpointAddress, @SubscriberID, packageID )

            if !billingRef.blank?
              urlBuilder += '?billingRef=' + billingRef
            end

            resource = ::RestClient::Resource.new( URI::encode(urlBuilder),
              :headers => {
                :content_type => 'application/binary',
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

              if response && response.respond_to?(:include?)
                if response.include?("HotDocs.Cloud.Storage.PackageNotFoundException")
                  response = func.call(true)
                  raise Storage::PackageNotFoundException, response if response.include?("HotDocs.Cloud.Storage.PackageNotFoundException")
                elsif response.include?("HotDocs.Cloud.EmbeddedSvc.ResumeSession")
                  raise Storage::EmptyResumeSessionAnswerException, response
                end
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
            #  - billingRef: This parameter lets you specify information that will be included in usage logs for this call. For example, you can use a string to uniquely identify the end user that initiated the request and/or the context in which the call was made. When you review usage logs, you can then see which end users initiated each request. That information could then be used to pass costs on to those end users if desired.
            #  - uploadPackage: Indicates if the package should be uploaded (forcefully) or not. This should only be true if the package does not already exist in the Cloud Services cache.
            #
            # http://help.hotdocs.com/cloudservices/WSRef_Direct/api_assembledocument.htm
            # POST https://cloud.hotdocs.ws/hdcs/assemble/{subscriberID}/{packageID}/{templatename=null}
            #
            # SDK C#: https://github.com/HotDocsCorp/hotdocs-open-sdk/blob/master/HotDocs.Sdk.Cloud/Rest/RestClient.cs#L531
            #
            def AssembleDocumentImpl template, answers, settings, billingRef, uploadPackage
              # if !(template.Location.is_a?(PackageTemplateLocation))
              #   raise "HotDocs Cloud Services requires the use of template packages. Please use a PackageTemplateLocation derivative."
              # end
              # packageTemplateLocation = template.Location

              packageID = template.packageID
              packageFile = template.file_url
              templateName = nil
              outputFormat = Server::Contracts::OutputFormat.Native # Don't Put the numeric value here ! It break the hmac !

              if uploadPackage
                UploadPackage(packageID, billingRef, packageFile)
              end

              timestamp = DateTime.now
              paramList = [ timestamp, @SubscriberID, packageID, templateName, false, billingRef, outputFormat, settings ]
              hmac = Server::Contracts::HMAC.CalculateHMAC(@SigningKey, paramList)
              urlBuilder = File.join( @EndpointAddress, 'assemble', @SubscriberID, packageID, templateName || '', "?format=#{ outputFormat.to_s }" )

              if !billingRef.blank?
                urlBuilder += '&billingRef=' + billingRef
              end

              if settings
                settings.each do |k, v|
                  urlBuilder += "&#{k.to_s}=#{v || ''}"
                end
              end

              # Missing Output settings

              # // Note that the Comments and/or Keywords values, and therefore the resulting URL, could
              # // be extremely long.  Consumers should be aware that overly-long URLs could be rejected
              # // by Cloud Services.  If the Comments and/or Keywords values cannot be truncated, the
              # // consumer should use the SOAP version of the client.
              # var outputOptionsPairs = GetOutputOptionsPairs(settings.OutputOptions);
              # foreach (KeyValuePair<string, string> kv in outputOptionsPairs)
              # {
              #   urlBuilder.AppendFormat("&{0}={1}", kv.Key, kv.Value ?? "");
              # }

              p urlBuilder

              resource = ::RestClient::Resource.new( URI::encode(urlBuilder),
                :headers => {
                  :content_type => 'text/xml',
                  :"x-hd-date" => timestamp.utc,
                  :Authorization => hmac,
                  :content_length => answers ? answers.size : 0,
                  :timeout => 10 * 60 * 1000
                }
              )

              if !@ProxyServerAddress.blank?
                ::RestClient.proxy = @ProxyServerAddress
              end

              bytes = answers ? answers.force_encoding("UTF-8") : nil
              response = resource.post(bytes) do |response, request, result|
                # p response
                result
              end

              if response.body.include?('Content-Disposition')
                FileUtils.mkdir_p( outputDir ) unless File.exists?(outputDir)

                # h =>
                # {
                #   string fileName = GetFileNameFromHeaders(h);
                #   if (fileName != null)
                #   {
                #     if (fileName.Equals("meta0.xml", StringComparison.OrdinalIgnoreCase))
                #     {
                #       return resultsStream;
                #     }
                #     return new FileStream(Path.Combine(outputDir, fileName), FileMode.Create);
                #   }
                #   return Stream.Null;
                # },
                h = -> (header_hash) do
                  filename = GetFileNameFromHeaders(header_hash)
                  if filename
                    return 'meta0.xml' if filename == 'meta0.xml' # resultsStream
                    filepath = File.join(outputDir, filename)
                    return File.new(filepath, 'w+')
                  end
                  nil
                end

                boundary = response.body.headers[:content_type][/boundary=(.*)$/, 1]

                # Each part is written to a file whose name is specified in the content-disposition
                # header, except for the AssemblyResult part, which has a file name of "meta0.xml",
                # and is parsed into an AssemblyResult object.
                multipart_mime_parser = MultipartMimeParser.new
                multipart_mime_parser.WritePartsToStreams(response.body, h, boundary)

                #   if (resultsStream.Position > 0)
                #   {
                #     resultsStream.Position = 0;
                #     var serializer = new XmlSerializer(typeof(AssemblyResult));
                #     return (AssemblyResult)serializer.Deserialize(resultsStream);
                #   }
                #   return null;
                if resultsStream = multipart_mime_parser.resultsStream
                  require 'nokogiri'
                  return Nokogiri::XML(resultsStream)
                end
              end

              response.body
            end

          private
            def GetFileNameFromHeaders headers_hash
              content_disposition_header = headers_hash['Content-Disposition']
              content_disposition_header.split('; ').select { |el| el.start_with?('filename=') } .each { |x| x.slice!('filename=') } .first if content_disposition_header
            end
        end

      end
    end
  end
end
