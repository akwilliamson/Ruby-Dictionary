require 'rspec'
require 'term'

describe Term do
  before do
    Term.clear
  end

  it 'creates a new instance of term' do
    test_term = Term.new('coffee','a drink')
    test_term.should be_an_instance_of Term
  end

  describe '.all' do
    it 'is empty at first' do
      Term.all.should eq []
    end
  end

  describe '#save' do
    it 'saves the term to the list of terms' do
      test_term = Term.new('coffee','a drink')
      test_term.save
      Term.all.should eq [test_term]
    end
  end

  describe '#edit_definition' do
    it 'changes the definition of a term' do
      test_term = Term.new('tree', 'plant')
      test_term.edit_definition('bush')
      test_term.definition.should eq 'bush'
    end
  end

  describe '.delete' do
    it 'deletes the term selected' do
      test_term1 = Term.create('coffee','a drink')
      test_term2 = Term.create('tree','plant')
      Term.delete(1)
      Term.all.should eq [test_term1]
    end
  end


  describe '.clear' do
    it 'empties out all of the saved terms' do
      test_term = Term.new('coffee','a drink')
      test_term.save
      Term.clear
      Term.all.should eq []
    end
  end

  describe '.create' do
    it 'creates a new instance of Task' do
      test_term = Term.create('coffee','a drink')
      test_term.should be_an_instance_of Term
    end
    it 'saves the term to the list of terms' do
      test_term = Term.create('coffee','a drink')
      Term.all.should eq [test_term]
    end
  end

  it 'should return the name of the term' do
    test_term = Term.create('coffee', 'a drink')
    test_term.name.should eq 'coffee'
  end

  it 'should return the definition of the term' do
    test_term = Term.create('coffee', 'a drink')
    test_term.definition.should eq 'a drink'
  end

  describe '.search' do
    it 'returns the object according to the search word' do
      test_term = Term.create('tree', 'a plant used for wood')
      test_term2 = Term.create('treetop', 'a plant used for wood')
      Term.search('cup').should eq test_term
    end
  end
end





