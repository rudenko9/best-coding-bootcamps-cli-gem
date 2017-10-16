class BestCodingBootcamps::Bootcamp

  attr_accessor :name, :url
  @@all = []

  def initialize(name = nil, url = nil)
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_bootcamps
    main = Nokogiri::HTML(open("https://www.switchup.org/locations/nyc-coding-bootcamp"))
    main.search("div h3 a")[0..9].each do |b|
      bootcamp = self.new
      bootcamp.name = b.text.split(". ")[1]
      bootcamp.url = "https://www.switchup.org#{b.attribute("href")}"
    end
  end

  def ranking
    Nokogiri::HTML(open(self.url)).search("div.bootcamp-caption p span span").text
  end

  def about
    Nokogiri::HTML(open(self.url)).search("blockquote#topic-description p").text
  end

  def courses
    list = Nokogiri::HTML(open(self.url)).search("a.course-listing").collect do |c|
      c.text.strip
    end
    list.uniq
  end

  def self.find_bootcamp(input)
    self.all[input-1]
  end

end
