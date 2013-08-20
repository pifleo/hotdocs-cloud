# lib/hotdocs/cloud/client/rest_client.rb
require 'open-uri'
require 'rest_client'

module Hotdocs
  module Cloud
    module Client

      class RestClient
        ENDPOINT_ADDRESS = "https://cloud.hotdocs.ws" # OR https://europe.hotdocs.ws/

        def initialize subscriberID, signingKey, endpointAddress = nil, proxyAddress = nil
          @subscriberID    = subscriberID
          @signingKey      = signingKey
          @endpointAddress = endpointAddress || ENDPOINT_ADDRESS
          @proxyAddress    = proxyAddress
        end

        def CreateSession packageID, packageFile, billingRef: nil, answers: nil, markedVariables: nil, interviewFormat: 0, outputFormat: 2, settings: nil, theme: nil, showDownloadLinks: true
          TryWithoutAndWithPackage(packageID, billingRef, packageFile) do
            CreateSessionImpl(packageID, billingRef, answers, markedVariables, interviewFormat, outputFormat, settings, theme, showDownloadLinks)
          end
        end

        def UploadPackage packageID, billingRef, packageFile
          packageStream = packageFile.blank? ? nil : File.new(packageFile, "r")
          UploadPackageStream(packageID, billingRef, packageStream)
          packageStream.close if packageStream
        end

        # http://help.hotdocs.com/cloudservices/WSRef_Direct/api_uploadpackage.htm
        # PUT https://cloud.hotdocs.ws/hdcs/{subscriberID}/{packageID}
        def UploadPackageStream packageID, billingRef, packageStream
          utcNow = DateTime.now
          paramList = [ utcNow, @subscriberID, packageID, nil, true, billingRef ]
          str = Sdk::Server::Contracts::HMAC.CalculateHMAC(@signingKey, paramList)
          builder = [ @endpointAddress, "/RestfulSvc.svc/", @subscriberID, "/", packageID ].join

          if !billingRef.blank?
            builder += "?billingRef=" + billingRef
          end

          resource = ::RestClient::Resource.new( URI::encode(builder),
            :headers => {
              :content_type => "application/binary",
              :"x-hd-date" => utcNow.utc,
              :Authorization => str
            }
          )

          if !@proxyAddress.blank?
            ::RestClient.proxy = @proxyAddress
          end

          bytes = packageStream ? packageStream.read : nil
          response = resource.put(bytes) { |response, request, result| result }
          response.body
        end

        def ResumeSession state
          utcNow = DateTime.now
          paramList = [ utcNow, @subscriberID, state ]
          str = Sdk::Server::Contracts::HMAC.CalculateHMAC(@signingKey, paramList)
          builder = [ @endpointAddress, "/embed/resumesession/", @subscriberID ].join

          resource = ::RestClient::Resource.new( URI::encode(builder),
            :headers => {
              :content_type => "text/xml",
              :"x-hd-date" => utcNow.utc,
              :Authorization => str,
              :content_length => state ? state.size : 0
            }
          )

          if !@proxyAddress.blank?
            ::RestClient.proxy = @proxyAddress
          end

          bytes = state ? state.force_encoding("UTF-8") : nil

          response = resource.post(bytes) do |response, request, result|
            result
          end

          response.body
        end

        private
          def TryWithoutAndWithPackage packageID, billingRef, packageFile, &func
            response = func.call

            if response.include?("cannot be found")
              UploadPackage(packageID, billingRef, packageFile)
              response = func.call
            end

            response
            # rescue Exception => response # WIP - Network error
            #  puts "Error code: {#{response.code}}"
            #  raise response if !response.include?("cannot be found")
          end

          # http://help.hotdocs.com/cloudservices/WSRef_Embedded/newsession_call.htm
          # POST https://cloud.hotdocs.ws/embed/newsession/{subscriberID}/{packageID}
          def CreateSessionImpl packageID, billingRef, answers, markedVariables, interviewFormat, outputFormat, settings, theme, showDownloadLinks
            utcNow = DateTime.now
            paramList = [ utcNow, @subscriberID, packageID, billingRef, interviewFormat, outputFormat, settings ]
            str = Sdk::Server::Contracts::HMAC.CalculateHMAC(@signingKey, paramList)
            builder = [ @endpointAddress, "/embed/newsession/", @subscriberID, "/", packageID, "?interviewformat=", interviewFormat.to_s, "&outputformat=", outputFormat.to_s ].join

            if (markedVariables != nil && markedVariables.size > 0)
              builder += "&markedvariables=" + markedVariables.join(',')
            end

            if !theme.blank?
              builder += "&theme=" + theme
            end

            if !billingRef.blank?
              builder += "&billingref=" + billingRef
            end

            if showDownloadLinks
              builder += "&showdownloadlinks=true"
            end

            if settings
              settings.each do |k, v|
                builder += "&#{k}=#{v || ''}"
              end
            end

            resource = ::RestClient::Resource.new( URI::encode(builder),
              :headers => {
                :content_type => "text/xml",
                :"x-hd-date" => utcNow.utc,
                :Authorization => str,
                :content_length => answers ? answers.size : 0
              }
            )

            if !@proxyAddress.blank?
              ::RestClient.proxy = @proxyAddress
            end

            bytes = answers ? answers.force_encoding("UTF-8") : nil
            response = resource.post(bytes) { |response, request, result| result }

            response.body
          end

      end

    end
  end
end
