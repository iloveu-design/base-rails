# encoding: utf-8

class Inicis
  #require 'shellwords'

  @bank_codes = { '03' => '기업은행',   '04' => '국민은행',   '05' => '외환은행',
                  '07' => '수협중앙회', '11' => '농협중앙회', '20' => '우리은행',
                  '23' => 'SC제일은행', '27' => '씨티은행',   '32' => '부산은행',
                  '34' => '광주은행',   '39' => '경남은행',   '71' => '우체국',
                  '81' => '하나은행',   '88' => '신한은행'
                }

  class << self
    attr_reader :bank_codes
  end

  def self.secure_pay(params = {})
    params = params.merge(inipayhome: File.expand_path('../inicis', __FILE__),
                          mid: ENV['INICIS_ID'])

    path = File.expand_path('../secure_result.php', __FILE__)
    result = `php #{path} '#{params.to_json}'`

    ActiveSupport::JSON.decode(result).symbolize_keys
  end

  def self.secure_cancel(params = {})
    params = params.merge(inipayhome: File.expand_path('../inicis', __FILE__),
                          mid: ENV['INICIS_ID'])

    path = File.expand_path('../secure_cancel.php', __FILE__)
    result = `php #{path} '#{params.to_json}'`
    ActiveSupport::JSON.decode(result).symbolize_keys
  end

  def self.secure_pay_mobile(params = {})
    params = params.merge(inipayhome: File.expand_path('../inicis', __FILE__),
                          mid: ENV['INICIS_MID'])

    path = File.expand_path('../secure_result.php', __FILE__)
    result = `php #{path} '#{params.to_json}'`

    ActiveSupport::JSON.decode(result).symbolize_keys
  end

  def self.secure_cancel_mobile(params = {})
    params = params.merge(inipayhome: File.expand_path('../inicis', __FILE__),
                          mid: ENV['INICIS_MID'])

    path = File.expand_path('../secure_cancel.php', __FILE__)
    result = `php #{path} '#{params.to_json}'`
    ActiveSupport::JSON.decode(result).symbolize_keys
  end
end
