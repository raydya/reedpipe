Grape::API.logger Padrino.logger

module Reedpipe
  class App < Grape::API
    class << self
      def cascade
        []
      end

      def root
        @_root ||= File.expand_path('..', __FILE__)
      end

      def dependencies
        #@_dependencies ||= Dir[File.expand_path('../../api/*.rb', __FILE__)]
        folders = %w(../../api/*.rb ../../api/entity/*.rb)
        @_dependencies ||= folders.map { |file| Dir[File.expand_path(file, __FILE__)] }.flatten
      end

      def load_paths
        @_load_paths ||= [File.expand_path('../../api', __FILE__)]
      end

      ## NOTE: Taken from Padrino. Deprecated in master (0.13.0.rc1).
      ## Padrino apps must now modify $LOAD_PATH for themselves.
      ## See: https://github.com/padrino/padrino-framework/pull/1693
      ##
      # Concat to +$LOAD_PATH+ the given paths.
      #
      # @param [Array<String>] paths
      #   The paths to concat.
      #
      def set_load_paths(*paths)
        $LOAD_PATH.concat(paths).uniq!
      end

      def setup_application!
        @_configured ||= begin
          set_load_paths(*load_paths)
          Padrino.require_dependencies(dependencies, force: true)
          Grape::API.logger = Padrino.logger
          true
        end
      end

      def app_file
        ''
      end

      def public_folder
        ''
      end
    end

    setup_application!

    #middlewares
    #use Grape::Middleware::Logger

    mount Reedpipe::Api::V2
    mount Reedpipe::Api::V1

    add_swagger_documentation mount_path: "/swagger", base_path: "http://localhost:3000/api", api_version: "v2"

  end
end