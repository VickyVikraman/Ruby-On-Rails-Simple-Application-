namespace :detail do
  desc "TODO"
  task fetch: :environment do
    puts "Fetching"
    puts "#{Detail.all.inspect}"
    puts "#{Time.now}"
  end
end

