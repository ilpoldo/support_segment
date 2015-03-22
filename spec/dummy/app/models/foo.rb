require 'support_segment/sti_helpers'

class Foo < ActiveRecord::Base
  include SupportSegment::StiHelpers

end

require_dependency 'bar'