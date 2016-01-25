Rails.application.routes.draw do

  namespace :forums do
  get 'welcome/index'
  end

  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end

  draw :ckeditor
  draw :admin
  #draw :user
  #draw :www
  draw :employments
  draw :complaints
  draw :forums
  draw :ta
end
