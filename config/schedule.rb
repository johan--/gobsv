# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "#{path}/log/cron.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever


every :day, :at => '11:00am' do
  rake "employments:import"
end

every :day, :at => '08:00pm' do
  rake "employments:import"
end

every 30.minutes do
  rake "employments:jobs"
end

#every 30.minutes do
#  rake "forums:articles"
#end

#every 120.minutes do
#  rake "forums:retweets"
#end

#every 60.minutes do
#  rake "forums:documents"
#end

#every 300.minutes do
#  rake "forums:videos"
#end

#every 300.minutes do
#  rake "forums:facebook"
#end
