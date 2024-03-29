require 'logger'

class AppLogger
  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STDOUT)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    @logger.info(log(env, status, headers))
    [status, headers, body]
  end

  private

  def log(env, status, headers)
  	{
      Request: "#{env['REQUEST_METHOD']} #{env['REQUEST_PATH']}",
      Handler: "#{env['simpler.controller'].class}##{env['simpler.action']}",
      Parameters: env['simpler.params'],
      Response: "#{status} [#{headers['Content-Type']}] #{env['simpler.template_path']}"
    }
  end
end
