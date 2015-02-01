# lib/hotdocs/sdk/cloud/client_base.rb

module Hotdocs
  module Sdk
    module Cloud

      #
      # An abstract base class for clients that communicate with HotDocs Cloud Services.
      #
      class ClientBase

        ENDPOINT_ADDRESS = "https://europe.hotdocs.ws" # "https://cloud.hotdocs.ws"

        #
        # SubscriberId       :  The Subscriber's unique id.
        # SigningKey         :  The Subscriber's unique signing key.
        # EndpointAddress    :  Specifies an alternate address for the Cloud Services web service (e.g., https://127.0.0.1).
        # ProxyServerAddress :  Specifies the proxy server address (e.g., http://myfiddlermachine:8888).
        attr_accessor :SubscriberID, :SigningKey, :EndpointAddress, :ProxyServerAddress

        #
        # A constructor used to create a client that communicates with HotDocs Cloud Services.
        #
        def initialize subscriberID, signingKey, hostAddress = nil, servicePath = nil, proxyServerAddress = nil
          @SubscriberID       = subscriberID
          @SigningKey         = signingKey
          @EndpointAddress    = (hostAddress || ENDPOINT_ADDRESS) + servicePath
          @ProxyServerAddress = proxyServerAddress
        end

        #
        # Assembles a document from the specified template and answersets.
        #
        # Parameters:
        #   - template: The template to use with the request.
        #   - answers:  The answers to use with the request.
        #   - settings: The options to use when assembling the document.
        #   - billingRef:  This parameter lets you specify information that will be included in usage logs for this call. For example, you can use a string to uniquely identify the end user that initiated the request and/or the context in which the call was made. When you review usage logs, you can then see which end users initiated each request. That information could then be used to pass costs on to those end users if desired.
        #
        # Parameters are different than SDK to match CreateSessionImpl
        def AssembleDocument template, answers, outputFormat: 2, settings: nil, billingRef: nil
          TryWithoutAndWithPackage do |uploadPackage|
            AssembleDocumentImpl(template, answers, outputFormat, settings, billingRef, uploadPackage)
          end
        end

        def GetInterview template, answers, settings, billingRef
          raise "Not Implemented"
        end

        def GetComponentInfo template, includeDialogs, billingRef
          raise "Not Implemented"
        end

        def GetAnswers answers, billingRef
          raise "Not Implemented"
        end
      end

    end
  end
end
