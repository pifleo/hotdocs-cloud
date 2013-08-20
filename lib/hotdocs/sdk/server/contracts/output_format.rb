# lib/hotdocs/sdk/server/contracts/output_format.rb

module Hotdocs
  module Sdk
    module Server
      module Contracts

        # http://help.hotdocs.com/cloudservices/html/T_HotDocs_Sdk_Server_Contracts_OutputFormat.htm
        module OutputFormat
          Answers = 1
          DOCX = 0x100          # 256
          HFD = 0x800           # 2048
          HPD = 0x400           # 1024
          HTML = 8
          HTMLwDataURIs = 0x20  # 32
          JPEG = 0x1000         # 4096
          MHTML = 0x40          # 64
          Native = 2
          None = 0
          PDF = 4
          PlainText = 0x10      # 16
          PNG = 0x2000          # 8192
          RTF = 0x80            # 128
          WPD = 0x200           # 512

          def self.Answers; "Answers" end
          def self.DOCX; "DOCX" end
          def self.HFD; "HFD" end
          def self.HPD; "HPD" end
          def self.HTML; "HTML" end
          def self.HTMLwDataURIs; "HTMLwDataURIs" end
          def self.JPEG; "JPEG" end
          def self.MHTML; "MHTML" end
          def self.Native; "Native" end
          def self.None; "None" end
          def self.PDF; "PDF" end
          def self.PlainText; "PlainText" end
          def self.PNG; "PNG" end
          def self.RTF; "RTF" end
          def self.WPD; "WPD" end

        end

      end
    end
  end
end
