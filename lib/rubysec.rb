require 'open-uri'
require 'openssl'

class Rubysec
  URL = 'https://rubysec.com/advisories'.freeze
  TD = 'td'.freeze

  attr_reader :published_at, :rubygem, :title, :cve

  def initialize
    @published_at = []
    @rubygem = []
    @title = []
    @cve = []
  end

  def call
    parse_fields
    {
      published_at: published_at,
      rubygem: rubygem,
      title: title,
      cve: cve
    }
  end

  private

  def fetch_page
    Nokogiri::HTML(open(URL, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
  end

  def td_elements
    fetch_page.css(TD).map(&:text).map(&:strip)
  end

  def parse_fields
    td_elements.in_groups_of(4).each do |vul_elems|
      @published_at << vul_elems[0]
      @rubygem << vul_elems[1]
      @title << vul_elems[2]
      @cve << vul_elems[3]
    end
  end
end
