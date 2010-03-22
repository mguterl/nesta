class WordpressRedirects

  URL_MAPPING = {
    "9"   => "saving-time-and-sanity-with-applescript",
    "42"  => "problems-difficulties-and-frustrations",
    "78"  => "writing-good-factories",
    "84"  => "require-spec-helper",
    "91"  => "runit-and-delayed-job",
    "116" => "extending-formtastic-with-a-sprinkle-of-jquery",
  }

  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    if new_location = URL_MAPPING[request.params['p']]
      return [301, { 'Content-Type' => 'text/html', 'Location' => new_location }, []]
    end

    @app.call(env)
  end
end
