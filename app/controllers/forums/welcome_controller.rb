class Forum::WelcomeController < ForumsController
  def index
    @main = Forum::Theme.active.main.first
    @medias = Forum::Organization.where(kind: 'media').order(:name)
    @politics = Forum::Organization.where(kind: 'politic').order(:name)
    if @main
      @q = @main.entries.ransack(params[:q])
      @entries = @q.result()
    end
  end
end
