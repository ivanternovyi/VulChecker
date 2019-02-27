require 'open-uri'
require 'openssl'

class Rubysec
  URL = 'https://rubysec.com/advisories'.freeze
  TD = 'td'.freeze

  def call
    fetch_page.css(TD).map(&:text).map(&:strip)
  end

  private

  def fetch_page
    Nokogiri::HTML(open(URL, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
  end
end
