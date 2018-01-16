require "spec_helper"

RSpec.describe 'RSpecOperationTest' do
  class Result
    def initialize(success, model, errors)
      @success = success
      @model = model
      @errors = errors
    end

    def success?
      @success
    end
    def failure?
      ! @success
    end

    def [](name)
      return @model if name == "model"
      return @errors if name == "contract.default"
    end
  end

  Errors = Struct.new(:messages) do
    def errors
      self
    end
  end

  class Create
    def self.call(params)
      if params[:band] == "Rancid"
        model = Struct.new(:title, :band).new(params[:title].strip, params[:band])
        Result.new(true, model, nil)
      else

        Result.new( false, nil, Errors.new({band: ["must be Rancid"] }) )
      end
    end
  end

  include Trailblazer::Test::Assertions
  include Trailblazer::Test::Operation::Assertions


  let(:model) { Struct.new(:title, :band).new("__Timebomb__", "__Rancid__") }

  # params is sub-set, expected is sub-set and both get merged with *_valid.
    #- simple: actual input vs. expected
  #:pass
  describe "Create with sane data" do
    let(:params_pass) { { band: "Rancid" } }
    let(:attrs_pass)  { { band: "Rancid", title: "Timebomb" } }

    # just works
    it { assert_pass Create, { title: "Ruby Soho" }, { title: "Ruby Soho" } }
    # trimming works
    it { assert_pass Create, { title: "  Ruby Soho " }, { title: "Ruby Soho" } }
  end
  #:pass end

  #:pass-block
  describe "Create with sane data" do
    let(:params_pass) { { band: "Rancid" } }
    let(:attrs_pass)  { { band: "Rancid", title: "Timebomb" } }

    it do
      assert_pass Create, { title: " Ruby Soho" }, {} do |result|
        assert_equal "Ruby Soho", result["model"].title
      end
    end
  end
  #:pass-block end

    #- simple: actual input vs. expected
  #:fail
  describe "Create with invalid data" do
    let(:params_pass) { { band: "Rancid" } }

    it { assert_fail Create, { band: "Adolescents" }, [:band] }
  end
  #:fail end

    #- with block
  #:fail-block
  describe "Create with invalid data" do
    let(:params_pass) { { band: "Rancid" } }

    it do
      assert_fail Create, { band: " Adolescents" }, {} do |result|
        assert_equal( {:band=>["must be Rancid"]}, result["contract.default"].errors.messages )
      end
    end
  end
  #:fail-block end
end
