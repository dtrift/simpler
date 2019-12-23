module Simpler
  class Router
    class Route

      attr_reader :controller, :action

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
      end

      def match?(method, path)
        @method == method && path.match(@path)
      end

      def params(env)
        request = Rack::Request.new(env)
      end

      private

      def make_params(env_info)
        path = extract_params(@path)
        requests = extract_params(env_info)
        result = {}

        path.zip(requests) do |key, value|
          key = key.delete(':').to_sym
          result[key] = value
        end
        result
      end

      def extract_params(path_split)
        path_split = path_split.split('/')
        path_split.delete_at(0)
        path_split
      end

    end
  end
end
