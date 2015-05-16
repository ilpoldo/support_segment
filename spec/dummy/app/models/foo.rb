require 'support_segment/sti_helpers'

class Foo < ActiveRecord::Base
  include SupportSegment::StiHelpers

  has_many :bazs, -> { extending Baz.sti_association_extensions }

end

require_dependency 'bar'