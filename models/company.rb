# == Schema Information
#
# Table name: companies
#
#  id               :integer          not null, primary key
#  no               :integer          not null
#  company_name     :string(255)      not null
#  receipted_date   :string(255)      not null
#  destination_name :text
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_companies_on_no  (no) UNIQUE
#

class Company < ActiveRecord::Base
  def self.import_new_companies(companies)
    new_companies = []
    companies.each do |company|
      next if Company.exists?(no: company.no)

      company.save!
      new_companies << company
    end
    new_companies
  end

  def notify_to_twitter
    client.update("T-CARDの個人情報提供先に「#{company_name}」が追加されました(#{receipted_date}付)")
  rescue Twitter::Error => e
    Padrino.logger.error e.message
  end

  private

  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end
end
