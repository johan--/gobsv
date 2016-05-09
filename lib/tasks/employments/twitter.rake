namespace :employments do
  desc 'Auto tweet random employment / job'
  task :jobs => [:environment] do
    Employments::TwitterBot.client.update(Employments::Plaza.twt_job)
  end
end
