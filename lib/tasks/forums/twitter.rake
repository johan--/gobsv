namespace :forums do
  desc 'Auto tweet random article'
  task :articles => [:environment] do
  end
  desc 'Auto tweet postures'
  task :postures => [:environment] do
    cmd = "cd #{Rails.root.to_s}/tmp/; cutycapt --url=http://www.reformadepensiones.com/ --out=reforma.png"
    wasGood = system(cmd)
    if wasGood
      cmd = "cd #{Rails.root.to_s}/tmp/; convert reforma.png -crop 734x745+33+703 crop.png"
      wasGood = system(cmd)
      if wasGood
        UserMailer.postures_picture.deliver
      end
    end
  end
end
