require 'open-uri'
require 'openssl'

class Rubysec
  URL = 'https://rubysec.com/advisories?page='.freeze
  TD = 'td'.freeze

  attr_reader :page

  def initialize(page: 1)
    @page = page
  end

  def call
    fetch_page.css(TD).map(&:text).map(&:strip)
  end

  private

  def url_with_page
    URL + page.to_s
  end

  def fetch_page
    Nokogiri::HTML(open(url_with_page, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
  end
end
