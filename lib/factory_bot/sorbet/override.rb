# typed: true
# frozen_string_literal: true

module FactoryBot
  module Sorbet
    # @requires_ancestor: singleton(::FactoryBot::Internal)
    module Internal
      def register_factory(factory)
        factory.names.each do |name|
          Sorbet.module_eval <<~RUBY, __FILE__, __LINE__ + 1
            def #{name}(kind, *args, **kwargs, &block)
              ::FactoryBot.public_send(kind, #{name.inspect}, *args, **kwargs, &block)
            end
          RUBY
        end

        super
      end

    end
  end

  Internal.prepend Sorbet::Internal
end
