namespace :urlshortener, [:time_in_mins] do
  desc "Prune sites that have not been visited in a certain number of minutes or ever"
  task prune_short_urls: :environment do
    time = args[:time_in_mins].to_i
    puts "Pruning old shortened URLs..."
    ShortenedUrl.prune(time)
  end
end