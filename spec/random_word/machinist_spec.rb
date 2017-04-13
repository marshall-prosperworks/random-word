require File.expand_path("../spec_helper", File.dirname(__FILE__))
require 'machinist/machinable'
require 'machinist/blueprint'
require 'machinist/lathe'
require 'random_word/machinist'

describe RandomWord::Machinist do
  let(:klass){ Class.new(Struct.new(:name,:role)) do
      extend Machinist::Machinable
    end
  }

  it "allows the use of #sw in blue prints" do
    klass.blueprint do
      name {sw}
    end
    expect(klass.make.name).not_to be_nil
  end

  it "allows the use of #serial_word in blue prints" do
    klass.blueprint do
      name {serial_word}
    end
    expect(klass.make.name).not_to be_nil
  end

  it "return same word for each call to serial_word" do
    klass.blueprint do
      name {serial_word}
      role {serial_word}
    end

    klass.make.tap do |obj|
      expect(obj.name).to eq(obj.role)
    end
  end

end
