class ParseVulnerabilitiesService
  attr_reader :td_elements, :current_page

  def initialize
    rubysec = Rubysec.new
    @td_elements = rubysec.call
    @current_page = rubysec.page
    @vulnerabilities_start_count = Vulnerability.count
  end

  def call
    parse_vulnerabilities
    if @vulnerabilities_start_count != Vulnerability.count
      MailToUsersWorker.perform_async
      NotifyTelegramUsersWorker.perform_async
    end
  end

  private

  def parse_vulnerabilities
    return if td_elements.empty?
    return unless insert_vulnerabilities

    reinit_rubysec
    parse_vulnerabilities
  end

  def reinit_rubysec
    rubysec = Rubysec.new(page: current_page.next)
    @td_elements = rubysec.call
    @current_page = current_page.next
  end

  def insert_vulnerabilities
    td_elements.in_groups_of(4).each do |vul_elems|
      return if skip_elem?(vul_elems)

      Vulnerability.create(
        published_at: vul_elems[0].to_date,
        rubygem: vul_elems[1],
        title: vul_elems[2],
        cve: vul_elems[3]
      )
    end

    true
  end

  def skip_elem?(vul_elems)
    return unless Vulnerability.newest_date
    return true if vul_elems[0].to_date < Vulnerability.newest_date

    true if Vulnerability.newest.where(
           rubygem: vul_elems[1],
           title: vul_elems[2],
           cve: vul_elems[3]
         ).any?
  end
end
