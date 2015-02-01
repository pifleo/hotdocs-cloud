# lib/hotdocs/sdk/i_value.rb
module Hotdocs
  module Sdk

    # An enumeration for the various types of HotDocs answer values.
    module ValueType
      # An answer for an unknown variable type.
      Unknown        = 0
      # An answer for a Text variable.
      Text           = 1
      # An answer for a Number variable.
      Number         = 2
      # An answer for a Date variable.
      Date           = 3
      # An answer for a True/False variable or grouped child dialog.
      TrueFalse      = 4
      # An answer for a Multiple Choice variable.
      MultipleChoice = 5
      # An answer for an other variable.
      Other          = 6
    end

    # An interface for a HotDocs value.
    class IValue # IConvertible
      # Indicates the value type.
      attr_reader :Type
      # Indicates if the value is answered or not.
      attr_reader :IsAnswered
      # Indicates whether the value should be modifiable by an end user in the interview UI (default is true).
      attr_reader :UserModifiable

      # Writes the value to XML.
      # params:
      #  - writer: XmlWriter to which to write the value.
      def WriteXml writer
        raise "NotImplemented"
      end
    end

  end

end
