require 'spec_helper'
require 'support_segment/sti_helpers'

describe SupportSegment::StiHelpers do

  it "adds scopes" do
    expect(Foo).to respond_to(:bars)
  end

  it "scopes and associations create the correct instance" do
    new_bar = Foo.bars.new(something: 'foo')
    expect(new_bar).to be_a(Bar)
    expect(new_bar.something).to eql('foo')
  end

  it "scopes preserving the association proxy" do
    new_foo = Foo.new(something: 'foo')

    bazaar = new_foo.bazs.bazaars.build(factor: 2)
    expect(bazaar).to be_in(new_foo.bazs)
  end

end