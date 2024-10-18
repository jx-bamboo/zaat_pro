class Rack::Attack
  throttle('req/ip', limit: 10, period: 5.minutes) do |req|
    req.ip
  end

  throttle('logins/ip', limit: 2, period: 20.seconds) do |req|
    routes = Rails.configuration.rack_attack['routes']
    req.ip if (req.post? && routes.include?(req.path))
  end

  Rack::Attack.throttled_responder = lambda do |env|
    [ 429, {}, ['Hello, My Friend, I know what you want to do. Have a cup of coffee plz!']]
  end
end