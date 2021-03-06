require 'rulers/version'
require 'rulers/routing'
require 'rulers/util'
require 'rulers/dependencies'
require 'rulers/controller'
require 'rulers/file_model'
require 'rulers/sqlite_model'

module Rulers
  class Application
    def call(env)
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      if controller.get_response
        st, hd, rs = controller.get_response.to_a #
        [st, hd, [rs.body].flatten]
      else
        [200, {'Content-Type' => 'text/html'}, [text]]
      end
    end
  end
end
