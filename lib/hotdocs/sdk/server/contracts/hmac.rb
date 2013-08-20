# lib/hotdocs/sdk/server/contracts/HMAC.rb
require 'hmac-sha1'
require 'base64'

module Hotdocs
  module Sdk
    module Server
      module Contracts

        class HMAC

          def self.CalculateHMAC signingKey, paramList
            bytes = signingKey.force_encoding("UTF-8")
            s = Canonicalize(paramList)
            buffer = s.force_encoding("UTF-8")

            hmacsha = ::HMAC::SHA1.new(bytes)
            hmacsha.update(buffer)
            Base64.encode64(hmacsha.digest).strip
          end

          # WIP - Maybe HASH need debug
          def self.Canonicalize paramList
            source = paramList.map do |param|
              case param
              when String, Integer, Array, Fixnum
                param.to_s
              when TrueClass, FalseClass
                param.to_s.capitalize
              when DateTime
                param.utc.to_s[0..-7] + "Z"
              when Hash
                # string[] strArray = (from kv in (Dictionary<string, string>) param
                #    orderby kv.Key
                #    select kv.Key + "=" + kv.Value).ToArray<string>();
                strArray = param.sort.select { |k, v| [ k.to_s, "=", v ].join }
                strArray.join("\n")
              else
                ""
              end
            end
            source.join("\n")
          end

          # WIP
          # How to raise a class ?
          # Need to code this class
          def self.ValidateHMAC hmac, signingKey, paramList
            calculatedHMAC = CalculateHMAC(signingKey, paramList)
            if hmac != calculatedHMAC
              raise HMACException(hmac, calculatedHMAC, paramList)
            end
          end

        end

      end
    end
  end
end
