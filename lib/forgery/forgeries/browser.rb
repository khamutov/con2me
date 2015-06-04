class Forgery::Browser < Forgery
  def self.browser
    dictionaries[:browsers].random
  end

  def self.os
    dictionaries[:os].random
  end

  def self.source
    dictionaries[:source].random
  end

  def self.cookie
    return (700000*rand).round
  end

  def self.visit_date
    date1 = DateTime.new(2015,4,28,0,0,0)
    date2 = DateTime.new(2015,5,19,23,59,59)
    ::Time.at((date2.to_f - date1.to_f)*rand + date1.to_f)
  end
end