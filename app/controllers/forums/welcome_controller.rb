class Forums::WelcomeController < ForumsController
  def index
    @main = Forums::Theme.active.main.first
    @medias = Forums::Organization.where(kind: 'media').order(:name)
    @politics = Forums::Organization.where(kind: 'politic').order(:name)
  end
end
