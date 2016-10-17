# Class that holds custom configurations for Rack Attack
class Rack::Attack

  # Always allow requests from localhost
  # (blocklist & throttles are skipped)
  safelist('allow from localhost') do |req|
    # Requests are allowed if the return value is truthy
    '127.0.0.1' == req.ip || '::1' == req.ip
  end

  # Throttle requests to 50 requests per second per ip
  throttle('req/ip', :limit => 50, :period => 1.minute) do |req|
    req.path.starts_with?('/collections') && req.ip
  end
end
