require "rails_helper"

RSpec.describe UsersMailer, type: :mailer do
  describe "notify_with_vulnerabilities" do
    let(:user) { FactoryBot.create(:user) }
    let(:mail) { UsersMailer.notify_with_vulnerabilities(user) }

    it "renders the headers" do
      expect(mail.subject).to eq('New vulnerabilities')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['ivan@mail.com'])
    end
  end
end
