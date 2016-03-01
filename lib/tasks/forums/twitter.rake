namespace :forums do
  desc 'Auto tweet random article'
  task :articles => [:environment] do
    client = TWITTERBOT
    client.update(Forum::Entry.twt_article)
  end
  desc 'Auto retweets random'
  task :retweets => [:environment] do
    client = TWITTERBOT
    client.retweet(Forum::Entry.retweet_id)
  end
  desc 'Auto tweets random document urls'
  task :documents => [:environment] do
    client = TWITTERBOT
    client.update(Forum::Entry.twt_document)
  end
  desc 'Auto tweets random youtube urls'
  task :videos => [:environment] do
    client = TWITTERBOT
    client.update(Forum::Entry.twt_video)
  end
  desc 'Auto tweets random facebook urls'
  task :facebook => [:environment] do
    client = TWITTERBOT
    client.update(Forum::Entry.twt_facebook)
  end
  desc 'Auto tweet postures'
  task :postures => [:environment] do
    puts "===============> INICIO TEMP"
    cmd = "cd #{Rails.root.to_s}/tmp/; xvfb-run --server-args='-screen 0, 1600x900x24' cutycapt --url=http://www.reformadepensiones.com/ --out=reforma.png"
    puts cmd
    wasGood = system(cmd)
    puts "===============> TEMP #{wasGood}"
    if wasGood
      puts "===============> INICIO CONVERT"
      cmd = "cd #{Rails.root.to_s}/tmp/; convert reforma.png -crop 734x745+33+703 crop.png"
      wasGood = system(cmd)
      puts "===============> CONVERT"
      if wasGood
        UserMailer.postures_picture.deliver
      end
    end
  end
end



#xvfb-run firefox --server-args='-screen 0, 1600x900x24' cutycapt --url=http://www.reformadepensiones.com/ --out=reforma.png
