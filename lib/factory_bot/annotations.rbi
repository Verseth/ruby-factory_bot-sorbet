# typed: true
# frozen_string_literal: true

module FactoryBot
  class << self
    #: (Symbol, *top) ?{ -> void } -> Hash[Symbol, untyped]
    def attributes_for(name, *args, &block); end
  end
end
