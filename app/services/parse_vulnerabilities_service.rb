class ParseVulnerabilitiesService
  attr_reader :td_elements

  def initialize
    @td_elements = Rubysec.new.call
  end

  def call
    parse_vulnerabilities
  end

  private

  def parse_vulnerabilities
    td_elements.in_groups_of(4).each do |vul_elems|
      break if skip_elem?(vul_elems)
      Vulnerability.create(
        published_at: vul_elems[0].to_date,
        rubygem: vul_elems[1],
        title: vul_elems[2],
        cve: vul_elems[3],
      )
    end
  end

  def skip_elem?(vul_elems)
    return unless Vulnerability.newest_date
    return true if vul_elems[0].to_date > Vulnerability.newest_date

    true if Vulnerability.newest.where(
           rubygem: vul_elems[1],
           title: vul_elems[2],
           cve: vul_elems[3]
         ).any?
  end
end
