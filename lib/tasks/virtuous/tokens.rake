namespace :virtuous do
  namespace :tokens do
    desc "Refresh Virtuous Access Token"
    task :refresh_token => :environment do
      Virtuous::VirtuousAccessToken.refresh
    end
  end
end
