# lib/hotdocs/sdk/cloud/rest/multipart_mime_parser.rb
module Hotdocs
  module Sdk
    module Cloud
      module Rest

        # This class parses a multipart MIME stream.
        class MultipartMimeParser
          HEADER_DELIMITER = ': '
          CRLF = "\r\n"

          attr_reader :resultsStream

          #
          # Writes the MIME parts from streamIn to streams that are provided by the consumer.
          # If the output stream is a FileStream, it is disposed after the data is written to the file.
          #
          # Parameters:
          #   - streamIn
          #   - outputStreamGetter: A delegate that provides an output stream based on MIME part header values.
          #   - boundary
          #
          # TODO: A better implementation base on stream and tmp file inspired from:
          #   http://www.rubydoc.info/gems/rest-client/1.6.1/RestClient/Payload/Multipart#build_stream-instance_method
          #
          def WritePartsToStreams streamIn, outputStreamGetter, boundary
            boundaryBytes = ("#{CRLF}--" + boundary).force_encoding('UTF-8')

            streamIn = streamIn.force_encoding('binary')
            streamIn.split(boundaryBytes).each do |part|
              # Skip CR-LF if they are at the beginning of the string

              # Grab the 2 bytes that follow the boundary.
              # The two bytes will be CR-LF for normal boundaries, but they will
              # be "--" for the terminating boundary.
              part = part[ 2..-1 ] if part[0..1] == CRLF
              part = part[ 4..-1 ] if part[0..3] == "--#{CRLF}"
              part = nil if part.blank?

              # Note that if streamOut is Stream.Null, it doesn't hurt anything to dispose it.
              if part
                begin
                  streamOut = outputStreamGetter.call( GetHeaders(part) )
                  if streamOut
                    part = part[header_length(part)..-1]
                    part.sub!(/^(\s*\r\n)*/, '')
                    if streamOut == 'meta0.xml'
                      @resultsStream = part # Store meta0.xml in a global to get it from outside the class
                    else
                      streamOut.write(part.force_encoding('UTF-8'))
                    end
                  end
                rescue IOError => e
                  #some error occur, dir not writable etc.
                ensure
                  streamOut.close if streamOut != nil && streamOut.is_a?(File)
                end
              end

              part
            end

            # Clear data
            streamIn = nil
          end

          private
            #
            # Gets the MIME part headers and returns them in a dictionary.
            #
            # Parameters:
            #   - streamIn:
            #
            def GetHeaders streamIn
              header_params_array = streamIn[0..200].split(CRLF).take_while { |e| !e.blank? }
              Hash[header_params_array.map { |line| line.split(HEADER_DELIMITER, 2) }] if header_params_array
            end

            def header_length streamIn
              GetHeaders(streamIn).map {|el| el.join(HEADER_DELIMITER)}.join(CRLF).length
            end

        end
      end
    end
  end
end
