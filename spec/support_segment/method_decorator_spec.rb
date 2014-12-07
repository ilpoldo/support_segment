require 'spec_helper'
require 'support_segment/method_decorator'


describe SupportSegment::MethodDecorator do

  let(:dummy_class) do
    dummy_class = Class.new { extend SupportSegment::MethodDecorator }
    allow_any_instance_of(dummy_class).to receive(:a_method)

    dummy_class
  end    



  it ".before" do
    canary = Proc.new {}
    # TODO: figure out how to mock a Proc
    dummy_proc = Proc.new {canary.call}

    dummy_class.class_eval do
      before(:a_method, &dummy_proc)
    end
    
    expect(canary).to receive(:call)

    dummy_instance = dummy_class.new()
    dummy_instance.a_method 
  end

end