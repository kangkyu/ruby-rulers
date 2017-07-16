require 'rulers/version'
# require 'rulers/routing'

module Rulers
  class Application
    # The first number, 200 is the HTTP status code.
    # If you returned 404, then the web browser would show a 404 message -- page not found.
    # If you returned 500, the browser should say that there was a server error.

    # The next hash is the headers.
    # You can return all sorts of headers to
    # set cookies,
    # change security settings,
    # and many other things.

    # The important one for us right now is
    # 'Content-Type' which must be 'text/html'.
    # we want the page rendered as HTML
    # rather than text, JSON, XML, RSS etc

    # Finally, there's the content.
    # In this case we have only a single part
    # containing a string.

    # Soon we'll examine Rack's env object
    # which is a hash of interesting values
    def call(env)
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      [
        200,
        {'Content-Type' => 'text/html'},
        [text]
      ]
      # [
      #   404,
      #   {'Content-Type' => 'text/html'},
      #   []
      # ]
    end

    def get_controller_and_action(env)
      _, cont, action, after = env["PATH_INFO"].split('/', 4)
      cont = cont.capitalize
      cont += "Controller"

      [Object.const_get(cont), action]
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end
end
