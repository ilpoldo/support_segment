class Baz < ActiveRecord::Base
  include SupportSegment::StiHelpers
  belongs_to :foo
end

class Bazinga < Baz
end

class Bazaar < Baz
end