# lib/hotdocs/sdk/server/contracts/interview_format.rb

module Hotdocs
  module Sdk
    module Server
      module Contracts

        module InterviewFormat
          JavaScript = 0
          Silverlight = 1
          Unspecified = 2

          def self.JavaScript;  JavaScript  end
          def self.Silverlight; Silverlight end
          def self.Unspecified; Unspecified end
        end

      end
    end
  end
end
