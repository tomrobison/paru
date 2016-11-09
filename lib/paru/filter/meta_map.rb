# MetaMap (M.Map String MetaValue)
module Paru
  module PandocFilter

    require_relative "./node"

    class MetaMap < Node

      def initialize contents
        @children = Hash.new

        if contents.is_a? Hash
          contents.each_pair do |key, value|
            if not value.empty? and PandocFilter.const_defined? value["t"]
              @children[key] = PandocFilter.const_get(value["t"]).new value["c"]
            end
          end
        end
      end

      def [](key)
        if @children.key_exists?
          @children[key]
        end
      end

      def has_key? key 
        @children.has_key? key
      end

      def delete key
        @children.delete key
      end

      def ast_contents
        ast = Hash.new
        @children.each_pair do |key, value|
          ast[key] = value.to_ast
        end
        ast
      end

    end
  end
end
