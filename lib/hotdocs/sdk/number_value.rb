# lib/hotdocs/sdk/number_value.rb
module Hotdocs
  module Sdk

    # A HotDocs Number value.
    class NumberValue < IValue

      # NumberValue constructor
      # params
      #  - value: value
      #  - userModifiable: Whether this value should be modifiable by end users in the interview UI.
      def initialize value = nil, userModifiable = false
        @value   = value
        @protect = !userModifiable
      end

      # Equals description
      # params:
      #  - obj: obj
      # Return:
      #  - True or False
      def Equals obj
        obj.is_a?(TextValue) ? equals(obj) : false
      end

      private
        def equals operand
          raise InvalidOperationException if (!IsAnswered || !operand.IsAnswered)
          @value == operand.value # String.Compare(Value, operand.Value, StringComparison.OrdinalIgnoreCase) == 0
        end

      class InvalidOperationException < RuntimeError; end

    end

  end
end

=begin

namespace HotDocs.Sdk
{

  public struct NumberValue : IValue
  {
    /// <summary>
    /// Equals description
    /// </summary>
    /// <param name="obj">obj</param>
    /// <returns>True or False</returns>
    public override bool Equals(object obj)
    {
      return (obj is NumberValue) ? Equals((NumberValue)obj) : false;
    }

    private bool Equals(NumberValue operand)
    {
      if (!IsAnswered || !operand.IsAnswered)
        throw new InvalidOperationException();

      return Value.Equals(operand.Value);
    }

    /// <summary>
    /// Gets a hash code for the value.
    /// </summary>
    /// <returns>A hash code for the value.</returns>
    public override int GetHashCode()
    {
      return _value.GetHashCode();
    }

    /// <summary>
    /// NumberValue summary
    /// </summary>
    /// <param name="d">d</param>
    /// <returns>operator</returns>
    public static implicit operator NumberValue(double d)
    {
      return new NumberValue(d);
    }

    /// <summary>
    /// NumberValue summary
    /// </summary>
    /// <param name="i">i</param>
    /// <returns>operator</returns>
    public static implicit operator NumberValue(int i)
    {
      return new NumberValue((double)i);
    }

    /// <summary>
    /// Indicates the value type.
    /// </summary>
    public ValueType Type
    {
      get { return ValueType.Number; }
    }

    /// <summary>
    /// Indicates if the value is answered.
    /// </summary>
    public bool IsAnswered
    {
      get { return _value.HasValue; }
    }

    /// <summary>
    /// Indicates whether the value should be modifiable by an end user in the interview UI (default is true).
    /// </summary>
    public bool UserModifiable
    {
      get { return !_protect; }
    }

    /// <summary>
    /// Indicates the value.
    /// </summary>
    public double Value
    {
      get { return _value.Value; }
    }

    /// <summary>
    /// Writes the XML representation of the answer.
    /// </summary>
    /// <param name="writer">The XmlWriter to which to write the answer value.</param>
    public void WriteXml(System.Xml.XmlWriter writer)
    {
      writer.WriteStartElement("NumValue");

      if (_protect)
        writer.WriteAttributeString("userModifiable", System.Xml.XmlConvert.ToString(!_protect));

      if (IsAnswered)
        writer.WriteString(Value.ToString("F7", CultureInfo.InvariantCulture));
      else
        writer.WriteAttributeString("unans", System.Xml.XmlConvert.ToString(true));

      writer.WriteEndElement();
    }

#if DEBUG
    // for ease in the debugger...
    // for some reason just having a ToString() seems to work better/a little more smoothly
    // than defining a DebuggerDisplay attribute!
    /// <summary>
    /// Convert to string.
    /// </summary>
    /// <returns>A string representation of the value.</returns>
    public override string ToString()
    {
      if (IsAnswered)
        return Value.ToString();
      else
        return "Unanswered";
    }
#endif

    #region IConvertible Members

    /// <summary>
    /// Gets the type of value.
    /// </summary>
    /// <returns>The TypeCode for the value.</returns>
    public TypeCode GetTypeCode()
    {
      return TypeCode.Object;
    }

    /// <summary>
    /// Converts the value to a boolean
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/IFormatProvider/param[@name='provider']"/>
    /// <returns>A boolean representation of the answer.</returns>
    public bool ToBoolean(IFormatProvider provider)
    {
      if (!IsAnswered)
        throw new InvalidCastException();
      return Convert.ToBoolean(_value.Value);
    }

    /// <summary>
    /// Converts the value to a byte.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/IFormatProvider/param[@name='provider']"/>
    /// <returns>A byte representation of the answer.</returns>
    public byte ToByte(IFormatProvider provider)
    {
      if (!IsAnswered)
        throw new InvalidCastException();
      return Convert.ToByte(_value.Value);
    }

    /// <summary>
    /// Converts the value to a char.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/IFormatProvider/param[@name='provider']"/>
    /// <returns>A char representation of the answer.</returns>
    public char ToChar(IFormatProvider provider)
    {
      if (!IsAnswered)
        throw new InvalidCastException();
      return Convert.ToChar(_value.Value);
    }

    /// <summary>
    /// Converts the value to a DateTime.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/IFormatProvider/param[@name='provider']"/>
    /// <returns>A DateTime representation of the answer.</returns>
    public DateTime ToDateTime(IFormatProvider provider)
    {
      if (!IsAnswered)
        throw new InvalidCastException();
      return Convert.ToDateTime(_value.Value);
    }

    /// <summary>
    /// Converts the value to a decimal.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/IFormatProvider/param[@name='provider']"/>
    /// <returns>A decimal representation of the answer.</returns>
    public decimal ToDecimal(IFormatProvider provider)
    {
      if (!IsAnswered)
        throw new InvalidCastException();
      return Convert.ToDecimal(_value.Value);
    }

    /// <summary>
    /// Converts the value to a double.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/IFormatProvider/param[@name='provider']"/>
    /// <returns>A double representation of the answer.</returns>
    public double ToDouble(IFormatProvider provider)
    {
      if (!IsAnswered)
        throw new InvalidCastException();
      return _value.Value;
    }

    /// <summary>
    /// Converts the value to a 16-bit (short) integer.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/IFormatProvider/param[@name='provider']"/>
    /// <returns>A 16-bit (short) integer representation of the answer.</returns>
    public short ToInt16(IFormatProvider provider)
    {
      if (!IsAnswered)
        throw new InvalidCastException();
      return Convert.ToInt16(_value.Value);
    }

    /// <summary>
    /// Converts the value to a 32-bit integer.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/IFormatProvider/param[@name='provider']"/>
    /// <returns>A 32-bit (int) integer representation of the answer.</returns>
    public int ToInt32(IFormatProvider provider)
    {
      if (!IsAnswered)
        throw new InvalidCastException();
      return Convert.ToInt32(_value.Value);
    }

    /// <summary>
    /// Converts the value to a 64-bit integer.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/IFormatProvider/param[@name='provider']"/>
    /// <returns>A 64-bit (long) integer representation of the answer.</returns>
    public long ToInt64(IFormatProvider provider)
    {
      if (!IsAnswered)
        throw new InvalidCastException();
      return Convert.ToInt64(_value.Value);
    }

    /// <summary>
    /// Converts the value to an sbyte.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/IFormatProvider/param[@name='provider']"/>
    /// <returns>An sbyte representation of the answer.</returns>
    public sbyte ToSByte(IFormatProvider provider)
    {
      if (!IsAnswered)
        throw new InvalidCastException();
      return Convert.ToSByte(_value.Value);
    }

    /// <summary>
    /// Converts the value to a float.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/IFormatProvider/param[@name='provider']"/>
    /// <returns>A float representation of the answer.</returns>
    public float ToSingle(IFormatProvider provider)
    {
      if (!IsAnswered)
        throw new InvalidCastException();
      return Convert.ToSingle(_value.Value);
    }

    /// <summary>
    /// Converts the value to a string.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/IFormatProvider/param[@name='provider']"/>
    /// <returns>A string representation of the answer.</returns>
    public string ToString(IFormatProvider provider)
    {
      if (!IsAnswered)
        return null;
      return Convert.ToString(_value.Value, provider);
    }

    /// <summary>
    /// Converts the value to the specified type.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/Type/param[@name='conversionType']"/>
    /// <include file="../Shared/Help.xml" path="Help/IFormatProvider/param[@name='provider']"/>
    /// <returns>A representation of the answer in the specified type.</returns>
    public object ToType(Type conversionType, IFormatProvider provider)
    {
      if (conversionType.GUID == GetType().GUID)
        return this;
      switch (conversionType.FullName)
      {
        case "HotDocs.TextValue": return IsAnswered ? new TextValue(ToString(provider)) : TextValue.Unanswered;
        case "HotDocs.NumberValue": return IsAnswered ? new NumberValue(ToDouble(provider)) : NumberValue.Unanswered;
        case "HotDocs.DateValue": return IsAnswered ? new DateValue(ToDateTime(provider)) : DateValue.Unanswered;
        case "HotDocs.TrueFalseValue": return IsAnswered ? new TrueFalseValue(ToBoolean(provider)) : TrueFalseValue.Unanswered;
        case "HotDocs.MultipleChoiceValue": return IsAnswered ? new MultipleChoiceValue(ToString(provider)) : MultipleChoiceValue.Unanswered;
      }
      if (!IsAnswered)
        throw new InvalidCastException();
      return Convert.ChangeType(_value, conversionType, provider);

    }

    /// <summary>
    /// Converts the value to ushort.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/IFormatProvider/param[@name='provider']"/>
    /// <returns>A ushort representation of the answer.</returns>
    public ushort ToUInt16(IFormatProvider provider)
    {
      if (!IsAnswered)
        throw new InvalidCastException();
      return Convert.ToUInt16(_value.Value);
    }

    /// <summary>
    /// Converts the value to a uint.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/IFormatProvider/param[@name='provider']"/>
    /// <returns>A uint representation of the answer.</returns>
    public uint ToUInt32(IFormatProvider provider)
    {
      if (!IsAnswered)
        throw new InvalidCastException();
      return Convert.ToUInt32(_value.Value);
    }

    /// <summary>
    /// Converts the value to a ulong.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/IFormatProvider/param[@name='provider']"/>
    /// <returns>A ulong representation of the answer.</returns>
    public ulong ToUInt64(IFormatProvider provider)
    {
      if (!IsAnswered)
        throw new InvalidCastException();
      return Convert.ToUInt64(_value.Value);
    }

    #endregion
  }
}

=end
