

class Term
  @@all_terms = []

  def Term.all
    @@all_terms
  end

  def Term.clear
    @@all_terms = []
  end

  def Term.create(name, definition)
    new_term = Term.new(name, definition)
    new_term.save
    new_term
  end

  def Term.delete(index)
    @@all_terms.delete_at(index)
  end

  def Term.search(term_search)
    @@all_terms.find{|x| x.name == term_search}
  end


  def initialize(name, definition)
    @name = [name]
    @definition = [definition]
  end

  def save
    @@all_terms << self
  end

  def name
    @name
  end

  def add_definition(definition)
    @definition << definition
  end

  def add_name(name)
    @name << name
  end

  def definition
    @definition
  end

  def edit_definition(index, definition)
    @definition[index] = definition
  end
end
