class Word
  @@all_words = []

  def Word.all
    @@all_words
  end

  def Word.clear
    @@all_words = []
  end

  def Word.create(name, language)
    new_word = Word.new(name, language)
    new_word.save
    new_word
  end

  def initialize(name, language)
    @name = name
    @language = language
  end

  def save
    @@all_words << self
  end

  def name
    @name
  end

  def language
    @language
  end

end
