class Forums::WelcomeController < ForumsController
  def index
    @main = Forums::Theme.active.main.first
    @medias = Forums::Organization.where(kind: 'media').order(:name)
    @politics = Forums::Organization.where(kind: 'politic').order(:name)
    if @main
      @q = @main.entries.ransack(params[:q])
      @entries = @q.result()
    end
  end
end
