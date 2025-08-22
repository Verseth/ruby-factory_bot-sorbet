# typed: true
# frozen_string_literal: true

require 'factory_bot'
require 'booleans'

require_relative 'sorbet/version'
require_relative 'sorbet/override'

module FactoryBot
  # Main namespace of the `factory_bot-sorbet` gem
  # that provides support for static typing with sorbet and tapioca to `factory_bot`.
  module Sorbet
    extend self

    class Error < StandardError; end
  end
end
