class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base || ENV['SECRET_KEY_BASE']
  secret_key_base = SECRET_KEY[0]
  puts "******************************"
  p SECRET_KEY
  puts "******************************"
  p secret_key_base
  puts "******************************"
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, secret_key_base)
  end

  def self.decode(token)
    decoded = JWT.decode(token, secret_key_base).first
    HashWithIndifferentAccess.new decoded
  end
end
