class CreateVulnerabilities < ActiveRecord::Migration[5.0]
  def change
    create_table :vulnerabilities do |t|
      t.string :cve
      t.string :title
      t.string :rubygem
      t.date :published_at

      t.timestamps
    end
  end
end
