# lib/hotdocs/sdk/answer_collection.rb
module Hotdocs
  module Sdk

    # This started out as more of a transparent (i.e. public) class cluster,
    # but I turned TypedAnswer, ValueNode and ValueList into nested classes
    # as an experiment to see if this design pattern will work as well in C#/.NET
    # as it works in other, more dynamic languages such as Objective-C.

    # The Answer class is an implementation of the "opaque class cluster" pattern.
    # Callers do not create instances of Answer directly, but use AnswerCollection.CreateAnswer().
    # The object that is returned is actually an instance of a private subclass of Answer,
    # but you only access it via public methods and properties of the Answer class.
    class Answer

      # private AnswerCollection _coll;
      # private string _name;
      # private int _depth;
      # private bool _save; // whether this answer is savable/permanent or temporary
      # private bool _userExtendible; // whether users should be permitted (in the UI) to add/delete/move repeat iterations


      # The answer name. Corresponds to a HotDocs variable name.
      attr_reader :name
      # The type of value that is stored in this answer.
      attr_reader :type

      # Factory method:
      def self.Create parent, name
        p "Answer.Create(_, '#{name}')"
        TypedAnswer.new(parent, name)
      end

      # Sets the value for an answer.
      # parameters:
      #  - value: The new value for the answer.
      #  - rptIdx:
      def SetValue value, rptIdx = nil
        # The first parameter to GetValueNode (below) determines whether it will create nodes as necessary
        # to get to the requested index.  We only bother to expand the tree if the value we're setting
        # is answered.
        nodeCreatedForUnansweredValue = false
        node = GetValueNode(value.IsAnswered, rptIdx)

        # if we're setting a value that's answered, GetValueNode should always be returning something!
        # (When we set things to unanswered, the tree won't be expanding to hold the value, so we may get null back.)
        if node.nil?
          # we're setting an unanswered value into the answer collection.
          # In this case we still need to expand the tree to have a place representing that unanswered value.
          node = GetValueNode(true, rptIdx);
          nodeCreatedForUnansweredValue = true;
        end

        if node != nil
          same = ((!value.IsAnswered && !node.value.IsAnswered) || (value.IsAnswered && node.value.IsAnswered && value.Equals(node.value) ))

          node.value = value;

          if (!same || nodeCreatedForUnansweredValue)
            # if we have un-answered a repeated variable; perform any value tree cleanup that is needed
            Recalculate(rptIdx) if (rptIdx != nil && rptIdx.size > 0 && !value.IsAnswered)
          end
        end
      end

      # Initializes the value for an answer.
      # parameters:
      #  - value: The new value for the answer.
      #  - rptIdx: int[]
      def InitValue value, rptIdx
        SetValue(value, rptIdx)
      end

      protected
        # A reference to the AnswerCollection this Answer belongs to.
        attr_reader :coll
        # The current repeat depth of this answer.  Non-repeated answers have a Depth of 0.
        attr_accessor :depth

        # Protected constructor for Answer objects.
        # Answer objects need not be constructed directly by callers;
        # use AnswerCollection.Create() instead.
        # parameters:
        #  - parent: The AnswerCollection the answer should be a part of.
        #  - name: The answer name.
        def initialize parent, name
          @coll = parent
          @name = name
          @save = !name.blank? && name[0] != "("
          @userExtendible = true
        end
    end

  end
end

=begin


  /*
   *
   */
  public abstract partial class Answer
  {
    /// <summary>
    /// When HotDocs saves a collection of answers as an Answer File, this flag determines whether this specific answer
    /// will be saved or not. If true (the default), the answer will be saved.  If false, this answer will be
    /// ignored/dropped and will not be persisted with the rest of the answers in the AnswerCollection.
    /// </summary>
    public bool Save
    {
      get { return _save; }
      set
      {
        if (!_save && value) // LRS: I don't expect this to happen
          throw new InvalidOperationException("Attempted to designate a non-savable answer as savable.");
        _save = value;
      }
    }

    /// <summary>
    /// For answers containing repeated values, indicates whether end users should be allowed to add/delete/move
    /// repeat iterations in the interview UI (default is true).
    /// </summary>
    public bool UserExtendible
    {
      get { return _userExtendible; }
      internal set { _userExtendible = value; }
    }

    /// <summary>
    /// Indicates whether this answer is repeated or not.
    /// </summary>
    public abstract bool IsRepeated { get; }

    /// <summary>
    /// Indicates whether (or not) a value is available at the indicated repeat indices.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/intAry/param[@name='rptIdx']"/>
    /// <returns>True or False</returns>
    public abstract bool GetAnswered(params int[] rptIdx);

    /// <summary>
    /// Indicates whether (or not) a value should be modifiable by the user in the interview UI.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/intAry/param[@name='rptIdx']"/>
    /// <returns>True or False</returns>
    public abstract bool GetUserModifiable(params int[] rptIdx);

    /// <summary>
    /// Indicates the number of child values at the specified repeat index.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/intAry/param[@name='rptIdx']"/>
    /// <returns>The number of children</returns>
    public abstract int GetChildCount(params int[] rptIdx);

    /// <summary>
    /// Indicates the number of sibling values for the specified repeat index.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/intAry/param[@name='rptIdx']"/>
    /// <returns>The number of siblings</returns>
    public abstract int GetSiblingCount(params int[] rptIdx);

    /// <summary>
    /// This method returns a specific value node from an answer.
    /// </summary>
    /// <typeparam name="T">The type of value being requested.</typeparam>
    /// <param name="createIfNecessary">Indicates if the node will be created if necessary.</param>
    /// <include file="../Shared/Help.xml" path="Help/intAry/param[@name='rptIdx']"/>
    /// <returns>A <c>ValueNode</c> for the value found at the specified repeat index.</returns>
    protected abstract ValueNode<T> GetValueNode<T>(bool createIfNecessary, params int[] rptIdx) where T : IValue;

    /// <summary>
    /// This method returns a specific value from an answer.
    /// </summary>
    /// <typeparam name="T">The type of value being requested.</typeparam>
    /// <include file="../Shared/Help.xml" path="Help/intAry/param[@name='rptIdx']"/>
    /// <returns>The value found at the specified repeat index.</returns>
    public T GetValue<T>(params int[] rptIdx) where T : IValue
    {
      ValueNode<T> node = GetValueNode<T>(false, rptIdx);
      if (node != null)
        return node.Value;
      else
        return default(T);
    }

    /// <summary>
    /// Gets the specified value.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/intAry/param[@name='rptIdx']"/>
    /// <returns>A value.</returns>
    public abstract IValue GetValue(params int[] rptIdx);






    /// <summary>
    /// Clears the answer.
    /// </summary>
    public abstract void Clear();

    /// <summary>
    /// Inserts an answer at the specified indexes.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/intAry/param[@name='rptIdx']"/>
    public abstract void InsertIteration(int[] rptIdx);

    /// <summary>
    /// Deletes an answer at the specified indexes.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/intAry/param[@name='rptIdx']"/>
    public abstract void DeleteIteration(int[] rptIdx);

    /// <summary>
    /// Moves an answer value from one repeat index to another.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/intAry/param[@name='rptIdx']"/>
    /// <param name="newPosition">newPosition</param>
    public abstract void MoveIteration(int[] rptIdx, int newPosition);

    /// <summary>
    /// Recalculates an answer.
    /// </summary>
    /// <include file="../Shared/Help.xml" path="Help/intAry/param[@name='rptIdx']"/>
    protected abstract void Recalculate(int[] rptIdx);

    /// <summary>
    /// Writes an answer to XML.
    /// </summary>
    /// <param name="writer">The XML writer.</param>
    /// <param name="writeDontSave">If writeDontSave is non-zero, answers with the Save == false property are saved to the writer.</param>
    public abstract void WriteXml(System.Xml.XmlWriter writer, bool writeDontSave);

    /// <summary>
    /// The ValueMutator delegate.
    /// </summary>
    /// <typeparam name="T">type</typeparam>
    /// <param name="value">value</param>
    /// <returns>Type</returns>
    public delegate T ValueMutator<T>(T value);

    /// <summary>
    /// ApplyValueMutator uses the Visitor design pattern to modify all the values associated with this answer
    /// by applying the ValueMutator delegate, in turn, to each value.  This can be useful if you want to
    /// apply the same modification to all values in an answer, such as marking all of them userModifiable=false.
    /// </summary>
    /// <typeparam name="T">type</typeparam>
    /// <param name="mutator">mutator</param>
    public abstract void ApplyValueMutator<T>(ValueMutator<T> mutator) where T : IValue;

    /// <summary>
    /// The ValueEnumeration delegate.
    /// </summary>
    /// <param name="state">state</param>
    /// <param name="indices">indices</param>
    public delegate void ValueEnumerationDelegate(object state, int[] indices);

    /// <summary>
    /// EnumerateValues uses the Visitor design pattern to enumerate all the values associated with this answer.
    /// For each value that is part of the answer, the supplied state object is passed to the supplied callback
    /// method, along with the repeat indices for that value.  The callback must be a delegate of type ValueEnumerationDelegate.
    /// </summary>
    /// <param name="state">An object to keep track of whatever state you will need during the enumeration.
    /// For simple enumerations, passing a reference to the Answer object in question
    /// (so you can use the repeat indices to look up values) may be adequate.</param>
    /// <param name="callback">A delegate of type ValueEnumerationDelegate.</param>
    public abstract void EnumerateValues(object state, ValueEnumerationDelegate callback);

    /// <summary>
    /// IndexedValues provides a simple way to enumerate (and potentially modify) the values associated with an answer.
    /// </summary>
    public abstract IEnumerable<IndexedValue> IndexedValues { get; }
  }
}

=end
