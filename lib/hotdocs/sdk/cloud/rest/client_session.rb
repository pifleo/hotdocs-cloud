# lib/hotdocs/sdk/cloud/rest/rest_client_session.rb

module Hotdocs
  module Sdk
    module Cloud
      module Rest

        module ClientSession
          # InterviewFormat.JavaScript
          # OutputFormat.Native
          def CreateSession template, billingRef: nil, answers: nil, markedVariables: nil, interviewFormat: 0, outputFormat: 2, settings: nil, theme: nil, showDownloadLinks: true, docUrl: nil, altDocUrl: nil, postUrl: nil
            TryWithoutAndWithPackage do |uploadPackage|
              CreateSessionImpl(template, billingRef, answers, markedVariables, interviewFormat, outputFormat, settings, theme, showDownloadLinks, docUrl, altDocUrl, postUrl, uploadPackage)
            end
            # rescue Storage::PackageNotFoundException => e
            #  nil
          end

          #
          # Resumes a saved session.
          #
          # Parameters:
          #  - state: The serialized state of the interrupted session, i.e. the "snapshot".
          #
          # Return:
          #   A session ID to be passed into the JavaScript HD$.CreateInterviewFrame call.
          def ResumeSession state, streamGetter
            if streamGetter
              return TryWithoutAndWithPackage do |uploadPackage|
                ResumeSessionImpl(state, streamGetter, uploadPackage)
              end
            end

            ResumeSessionImpl(state, streamGetter, false)
          end

          #
          # Parameters:
          #  - sessionId:
          #  - fileName:
          #  - localPath:
          # http://help.hotdocs.com/cloudservices/html/M_HotDocs_Cloud_Client_RestClient_GetSessionDoc.htm
          def GetSessionDoc sessionId, fileName, localPath
            url = [ @EndpointAddress, "/embed/session/", sessionId, "/docs/", fileName ].join
            open(localPath, 'wb+') do |file|
              file << open(url).read
            end
          end

          #
          # Parameters:
          #  - sessionId:
          # http://help.hotdocs.com/cloudservices/html/M_HotDocs_Cloud_Client_RestClient_GetSessionDocList.htm
          def GetSessionDocList sessionId
            url = [ @EndpointAddress, "/embed/session/", sessionId, "/docs" ].join
            list = open(url).read
            list.split("\r\n").compact - [""] if list
          end

          #
          # Parameters:
          #  - sessionId:
          # http://help.hotdocs.com/cloudservices/html/M_HotDocs_Cloud_Client_RestClient_GetSessionState.htm
          # Not working ??
          def GetSessionState sessionId
            url = [ @EndpointAddress, "/embed/session/", sessionId, "/state" ].join
            open(url).read
          end

          private

            # http://help.hotdocs.com/cloudservices/WSRef_Embedded/newsession_call.htm
            # POST https://cloud.hotdocs.ws/embed/newsession/{subscriberID}/{packageID}
            #
            # TODO: Patch to use the PackageTemplateLocation class
            def CreateSessionImpl template, billingRef, answers, markedVariables, interviewFormat, outputFormat, settings, theme, showDownloadLinks, docUrl, altDocUrl, postUrl, uploadPackage
              # if !(template.Location.is_a?(PackageTemplateLocation))
              #   raise "HotDocs Cloud Services requires the use of template packages. Please use a PackageTemplateLocation derivative."
              # end
              # packageTemplateLocation = template.Location

              packageID = template.packageID
              packageFile = template.file_url

              if uploadPackage
                UploadPackage(packageID, billingRef, packageFile)
              end

              timestamp = DateTime.now
              paramList = [ timestamp, @SubscriberID, packageID, billingRef, interviewFormat, outputFormat, nil ] # Additional settings = null for this app
              hmac = Server::Contracts::HMAC.CalculateHMAC(@SigningKey, paramList)

              urlBuilder = [ @EndpointAddress, "/embed/newsession/", @SubscriberID, "/", packageID, "?interviewformat=", interviewFormat.to_s, "&outputformat=", outputFormat.to_s ].join

              if (markedVariables != nil && markedVariables.size > 0)
                urlBuilder += "&markedvariables=" + markedVariables.join(',')
              end

              if !postUrl.blank?
                urlBuilder += "&posturl=" + postUrl
              end

              if !theme.blank?
                urlBuilder += "&theme=" + theme
              end

              if !billingRef.blank?
                urlBuilder += "&billingref=" + billingRef
              end

              if showDownloadLinks
                urlBuilder += "&showdownloadlinks=true"
              end

              if !altDocUrl.blank?
                urlBuilder += "&altdocurl=" + altDocUrl
              end

              if !docUrl.blank?
                urlBuilder += "&docurl=" + docUrl
              end

              # if settings
              #   settings.each do |k, v|
              #     urlBuilder += "&#{k.to_s}=#{v || ''}"
              #   end
              # end

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
                response
              end

              response.body
            end

            def ResumeSessionImpl state, streamGetter, uploadPackage
              if uploadPackage
                base64 = state.split('#').first
                json = Base64.decode64(base64).force_encoding("UTF-8")
                stateDict = JSON.parse(json)
                packageID = stateDict["PackageID"]
                billingRef = stateDict["BillingRef"]

                # UploadPackage(packageID, billingRef, streamGetter(packageID)); C#
                UploadPackage(packageID, billingRef, streamGetter.call(packageID))
              end

              timestamp = DateTime.now

              paramList = [ timestamp, @SubscriberID, state ]
              hmac = Server::Contracts::HMAC.CalculateHMAC(@SigningKey, paramList)

              url = [ @EndpointAddress, "/embed/resumesession/", @SubscriberID ].join

              resource = ::RestClient::Resource.new( URI::encode(url),
                :headers => {
                  :content_type => "text/xml",
                  :"x-hd-date" => timestamp.utc,
                  :Authorization => hmac,
                  :content_length => state ? state.size : 0
                }
              )

              if !@ProxyAddress.blank?
                ::RestClient.proxy = @ProxyAddress
              end

              bytes = state ? state.force_encoding("UTF-8") : nil
              response = resource.post(bytes) do |response, request, result|
                if [301, 302, 307].include? response.code
                  #response.follow_redirection(request, result, &block)
                  response.follow_redirection(request, result)
                else
                  response
                end
              end

              response.body
            end
        end

      end
    end
  end
end
