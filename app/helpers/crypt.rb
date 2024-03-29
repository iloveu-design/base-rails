module Crypt
  class << self
    def encrypt(value)
      crypt(:encrypt, value)
    end

    def decrypt(value)
      crypt(:decrypt, value)
    end

    def encryption_key
      key = ENV['ENCRYPTION_KEY']

      if Rails.env.development? && !key.present?
        key = 'slowalk'
      end

      raise "Error: no encryption key found." unless key.present?

      key
    end

    ALGO = 'aes-256-cbc'.freeze
    def crypt(cipher_method, value)
      cipher = OpenSSL::Cipher.new(ALGO)
      cipher.send(cipher_method)
      cipher.pkcs5_keyivgen(encryption_key)
      result = cipher.update(value)
      result << cipher.final
    end
  end
end