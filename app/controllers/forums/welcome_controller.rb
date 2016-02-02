class Forums::WelcomeController < ForumsController
  def index
    @main = Forums::Theme.active.main.first
  end
end
