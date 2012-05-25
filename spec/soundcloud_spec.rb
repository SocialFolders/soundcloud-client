describe :VERSION do
  subject { Soundcloud::VERSION }
  it { should be_a String }
  it { should match /^\d+\.\d+\.\d+/ }
end


describe Soundcloud::API do

  it "should raise ArgumentError when initialized with no options" do
    lambda do
      Soundcloud::API.new
    end.should raise_error ArgumentError
  end

  before do
    @api = Soundcloud::API.new("fake", verbose: false, stubs: STUBS)
  end

  subject { @api }

  describe "when receiving errors" do
    it "should raise correct error from a haproxy error page (503)" do
      lambda {
        subject.user_playlists id: "haproxy_error"
      }.should raise_exception Soundcloud::Error::ServiceUnavailable
    end

    it "should raise correct error from a server error page (503)" do
      lambda {
        subject.user_playlists id: "bleh"
      }.should raise_exception Soundcloud::Error::ServiceUnavailable
    end
  end

  describe "when receiving data" do
    it "should wrap the response object of a single resource in a hash" do
      subject.track(123).should be_a Hash
    end
    it "should wrap the response object of a colletion in a list of hashes" do
      result = subject.tracks
      result.should be_a Array
      result.should_not be_empty
      result.each do |m|
        m.should be_a Hash
      end
    end

  end

  describe :id_of do

    it "should pass through basic types" do
      subject.id_of("me").should == "me"
      subject.id_of(123).should == 123
    end
    it "extract id from hash" do
      subject.id_of({id: "my_id"}).should == "my_id"
      subject.id_of({"id" => "my_id"}).should == "my_id"
    end
  end

  describe "have connection wrappers" do
    before do
      @connection = mock(Faraday::Connection)
      subject.stub(:connection).and_return(@connection)
    end

    [:get, :post, :put, :delete].each do |verb|
      it "should hand out #{verb.inspect} to the connection" do
        @connection.should_receive(verb).and_return(mock(:response, body: "body"))
        subject.send verb
      end
    end
  end

  describe :connection do
    let(:args) { Array.new }
    subject { Soundcloud::API.new("fake", verbose: false).connection(*args) }
    it { should_not be_nil }

    describe "with no args" do
      let(:args) { Array.new }
      it "should be the default one" do should eql @api.class.connection end
    end

    describe "verbose" do
      let(:args) { [{verbose: true}] }
      it "should not be the default one" do should_not eql @api.class.connection end
      it "should contain a logger middleware" do
        subject.builder.handlers.any? { |h| h == Faraday::Response::Logger }
      end
    end

    describe "with stubs" do
      let(:args) { [{stubs: mock(:stubs)}] }
      it "should not be the default one" do should_not eql @api.class.connection end
      it "should end with a Stubs adapter" do
        subject.builder.handlers.last.should == Faraday::Adapter::Test
      end
    end
    
    it "should be verbose when the class is set as such" do
      Soundcloud::API.new("fake", verbose: true).connection.builder.handlers.any? { |h| h == Faraday::Response::Logger }
    end
    
    it "should be stubbed when the class is set as such" do
      Soundcloud::API.new("fake", stubs: mock(Faraday::Adapter::Test::Stubs)).connection.builder.handlers.last.should == Faraday::Adapter::Test
    end
    
  end

end
