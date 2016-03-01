namespace :forums do
  desc 'Auto tweet random article'
  task :articles => [:environment] do
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
