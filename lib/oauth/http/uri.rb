module Oauth
  module Http
    class Uri

      REGEX = /^(?=[^&])(?:(?<scheme>[^:\/?#]+):)?(?:\/\/(?<host>[^\/?#]*))\/?(?<path>[^?#]*)\?(?:\/?(?<query>[^#]*))?(?:#(?<fragment>.*))?/

      class << self
        def parse(uri)
          new(Uri::REGEX.match(uri))
        end

        def build(*args)
          params = args.extract_options!
          base   = args[0]

          return [base, params.to_param].join('?')
        end
      end

      attr_reader :scheme, :host, :path, :query, :fragment

      def initialize(parsed)
        @scheme   = parsed['scheme']
        @host     = parsed['host']
        @path     = parsed['path']
        @query    = parsed['query']
        @fragment = parsed['fragment']
      end

      def params
        params = Hash.new

        query.split(/[&;] */n).each do |p|
          next if p.empty?

          k, v = p.split('=', 2)
          params[k.to_sym] = v
        end

        return params
      end
    end
  end
end