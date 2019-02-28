class HomeController < ApplicationController
  def index
    @vulnerabilities = Vulnerability.all
  end
end
