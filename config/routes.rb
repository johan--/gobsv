Rails.application.routes.draw do

  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end

  draw :ckeditor
  draw :admin
  #draw :www
  draw :employments
  draw :complaints
  draw :forums
  draw :ta
  #draw :services
  draw :user
end
