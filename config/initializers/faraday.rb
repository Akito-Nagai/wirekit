module Faraday
  class Response
    class SymbolizedJson < Middleware
      def parse(body)
        JSON.parse(body, symbolize_names: true)
      end
    end
    register_middleware symbolized_json: SymbolizedJson
  end
end
