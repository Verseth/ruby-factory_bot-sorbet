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
            klass = factory.build_class
            mod.create_method(
              factory.name.to_s,
              parameters: [
                create_param('strategy', type: 'Symbol'),
                create_rest_param('args', type: 'top'),
                create_block_param('block', type: "T.proc.params(arg0: #{klass}).returns"),
              ],
            ) do |method|
              method.add_sig do |sig|
                sig.add_param('block', 'NilClass')
                sig.return_type = klass.to_s
              end

              method.add_sig do |sig|
                sig.type_params << 'R'
                sig.add_param('block', "T.proc.params(arg0: #{klass}).returns(T.type_param(:R))")
                sig.return_type = 'T.type_param(:R)'
              end
            end

          end
        end

      end

    end
  end
end
