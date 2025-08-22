# typed: true
# frozen_string_literal: true

require 'factory_bot/sorbet'

module Tapioca
  module Compilers
    #: [ConstantType = singleton(::FactoryBot::Sorbet)]
    class FactoryBot < Tapioca::Dsl::Compiler
      class << self
        # @override
        #: -> T::Enumerable[Module]
        def gather_constants
          [::FactoryBot::Sorbet]
        end
      end

      # @override
      #: -> void
      def decorate
        root.create_path(constant) do |mod|
          ::FactoryBot.factories.each do |factory|
            begin
              klass = factory.build_class
            rescue NameError
              next
            end

            mod.create_method(factory.name.to_s) do |method|
              method.add_param('strategy')
              method.add_rest_param('args')
              method.add_block_param('block')

              method.add_sig do |sig|
                sig.add_param('strategy', 'Symbol')
                sig.add_param('args', 'top')
                sig.add_param('block', 'NilClass')
                sig.return_type = klass.to_s
              end

              method.add_sig do |sig|
                sig.type_params << 'R'
                sig.add_param('strategy', 'Symbol')
                sig.add_param('args', 'top')
                sig.add_param('block', "T.proc.params(arg0: #{klass}).returns(T.type_parameter(:R))")
                sig.return_type = 'T.type_parameter(:R)'
              end
            end

          end
        end

      end

    end
  end
end
