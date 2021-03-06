require_relative 'helper'
require_relative '../lib/lotus/feed.rb'

describe Lotus::Feed do
  describe "#initialize" do
    it "should store a title" do
      Lotus::Feed.new(:title => "My Title").title.must_equal "My Title"
    end

    it "should store a title type" do
      Lotus::Feed.new(:title_type => "html").title_type.must_equal "html"
    end

    it "should store a subtitle" do
      Lotus::Feed.new(:subtitle => "My Title").subtitle.must_equal "My Title"
    end

    it "should store a subtitle type" do
      Lotus::Feed.new(:subtitle_type => "html").subtitle_type.must_equal "html"
    end

    it "should store a list of categories" do
      category = mock('category')
      Lotus::Feed.new(:categories => [category]).categories.must_equal [category]
    end

    it "should store a list of authors" do
      author = mock('author')
      Lotus::Feed.new(:authors => [author]).authors.must_equal [author]
    end

    it "should store a list of contributors" do
      author = mock('author')
      Lotus::Feed.new(:contributors => [author]).contributors.must_equal [author]
    end

    it "should store a list of entries" do
      entry = mock('entry')
      Lotus::Feed.new(:entries => [entry]).entries.must_equal [entry]
    end

    it "should store a list of hubs" do
      Lotus::Feed.new(:hubs => ["http://hub.example.com"]).hubs
        .must_equal ["http://hub.example.com"]
    end

    it "should store the id of the feed" do
      Lotus::Feed.new(:id => "id").id.must_equal "id"
    end

    it "should store the icon for the feed" do
      Lotus::Feed.new(:icon => "url").icon.must_equal "url"
    end

    it "should store the logo for the feed" do
      Lotus::Feed.new(:logo => "url").logo.must_equal "url"
    end

    it "should store the rights for the feed" do
      Lotus::Feed.new(:rights => "url").rights.must_equal "url"
    end

    it "should store the url for the feed" do
      Lotus::Feed.new(:url => "url").url.must_equal "url"
    end

    it "should store the published date" do
      time = mock('date')
      Lotus::Feed.new(:published => time).published.must_equal time
    end

    it "should store the updated date" do
      time = mock('date')
      Lotus::Feed.new(:updated => time).updated.must_equal time
    end

    it "should store the salmon url for the feed" do
      Lotus::Feed.new(:salmon_url => "url").salmon_url.must_equal "url"
    end

    it "should store the generator for the feed" do
      Lotus::Feed.new(:generator => "feedmaker").generator.must_equal "feedmaker"
    end

    it "should yield an empty array for categories by default" do
      Lotus::Feed.new.categories.must_equal []
    end

    it "should yield an empty array for authors by default" do
      Lotus::Feed.new.authors.must_equal []
    end

    it "should yield an empty array for contributors by default" do
      Lotus::Feed.new.contributors.must_equal []
    end

    it "should yield an empty array for entries by default" do
      Lotus::Feed.new.entries.must_equal []
    end

    it "should yield an empty array for hubs by default" do
      Lotus::Feed.new.hubs.must_equal []
    end

    it "should yield a title of 'Untitled' by default" do
      Lotus::Feed.new.title.must_equal "Untitled"
    end
  end

  describe "#to_link" do
    it "should return a Lotus::Link" do
      link = mock('link')
      Lotus::Link.stubs(:new).returns(link)
      Lotus::Feed.new.to_link.must_equal link
    end

    it "should by default use the title of the feed" do
      Lotus::Link.expects(:new).with(has_entry(:title, "title"))
      Lotus::Feed.new(:title => "title").to_link
    end

    it "should by default use the url of the feed as the href" do
      Lotus::Link.expects(:new).with(has_entry(:href, "http://example.com"))
      Lotus::Feed.new(:url => "http://example.com").to_link
    end

    it "should override the title of the feed when given" do
      Lotus::Link.expects(:new).with(has_entry(:title, "new title"))
      Lotus::Feed.new(:title => "title").to_link(:title => "new title")
    end

    it "should override the url of the feed when given" do
      Lotus::Link.expects(:new).with(has_entry(:url, "http://feeds.example.com"))
      Lotus::Feed.new(:url => "http://example.com")
        .to_link(:url => "http://feeds.example.com")
    end

    it "should pass through the rel option" do
      Lotus::Link.expects(:new).with(has_entry(:rel, "alternate"))
      Lotus::Feed.new.to_link(:rel => "alternate")
    end

    it "should pass through the hreflang option" do
      Lotus::Link.expects(:new).with(has_entry(:hreflang, "en_us"))
      Lotus::Feed.new.to_link(:hreflang => "en_us")
    end

    it "should pass through the length option" do
      Lotus::Link.expects(:new).with(has_entry(:length, 12345))
      Lotus::Feed.new.to_link(:length => 12345)
    end

    it "should pass through the type option" do
      Lotus::Link.expects(:new).with(has_entry(:type, "html"))
      Lotus::Feed.new.to_link(:type => "html")
    end
  end

  describe "#to_hash" do
    it "should return a Hash containing the title" do
      Lotus::Feed.new(:title => "My Title").to_hash[:title].must_equal "My Title"
    end

    it "should return a Hash containing the title type" do
      Lotus::Feed.new(:title_type => "html").to_hash[:title_type].must_equal "html"
    end

    it "should return a Hash containing the subtitle" do
      Lotus::Feed.new(:subtitle => "My Title").to_hash[:subtitle].must_equal "My Title"
    end

    it "should return a Hash containing the subtitle type" do
      Lotus::Feed.new(:subtitle_type => "html").to_hash[:subtitle_type].must_equal "html"
    end

    it "should return a Hash containing a list of categories" do
      category = mock('category')
      Lotus::Feed.new(:categories => [category]).to_hash[:categories].must_equal [category]
    end

    it "should return a Hash containing a list of authors" do
      author = mock('author')
      Lotus::Feed.new(:authors => [author]).to_hash[:authors].must_equal [author]
    end

    it "should return a Hash containing a list of contributors" do
      author = mock('author')
      Lotus::Feed.new(:contributors => [author]).to_hash[:contributors].must_equal [author]
    end

    it "should return a Hash containing a list of entries" do
      entry = mock('entry')
      Lotus::Feed.new(:entries => [entry]).to_hash[:entries].must_equal [entry]
    end

    it "should return a Hash containing a list of hubs" do
      Lotus::Feed.new(:hubs => ["hub1", "hub2"]).to_hash[:hubs]
        .must_equal ["hub1", "hub2"]
    end

    it "should return a Hash containing the id of the feed" do
      Lotus::Feed.new(:id => "id").to_hash[:id].must_equal "id"
    end

    it "should return a Hash containing the icon for the feed" do
      Lotus::Feed.new(:icon => "url").to_hash[:icon].must_equal "url"
    end

    it "should return a Hash containing the logo for the feed" do
      Lotus::Feed.new(:logo => "url").to_hash[:logo].must_equal "url"
    end

    it "should return a Hash containing the rights for the feed" do
      Lotus::Feed.new(:rights => "CC0").to_hash[:rights].must_equal "CC0"
    end

    it "should return a Hash containing the url for the feed" do
      Lotus::Feed.new(:url => "url").to_hash[:url].must_equal "url"
    end

    it "should return a Hash containing the salmon url for the feed" do
      Lotus::Feed.new(:salmon_url => "url").to_hash[:salmon_url].must_equal "url"
    end

    it "should return a Hash containing the published date" do
      time = mock('date')
      Lotus::Feed.new(:published => time).to_hash[:published].must_equal time
    end

    it "should return a Hash containing the updated date" do
      time = mock('date')
      Lotus::Feed.new(:updated => time).to_hash[:updated].must_equal time
    end

    it "should return a Hash containing the generator" do
      Lotus::Feed.new(:generator => "feedmaker").to_hash[:generator].must_equal "feedmaker"
    end
  end

  describe "#to_atom" do
    it "should relegate Atom generation to Lotus::Atom::Feed" do
      atom_entry = mock('atom')
      atom_entry.expects(:to_xml).returns("ATOM")

      require_relative '../lib/lotus/atom/feed.rb'

      Lotus::Atom::Feed.stubs(:new).returns(atom_entry)

      Lotus::Feed.new(:title => "foo").to_atom.must_equal "ATOM"
    end
  end
end
