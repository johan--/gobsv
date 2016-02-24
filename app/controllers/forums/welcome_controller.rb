class Forums::WelcomeController < ForumsController
  def index
    @main = Forum::Theme.active.main.first
    @medias = Forum::Organization.where(kind: 'media').order(:name)
    @politics = Forum::Organization.where(kind: 'politic').order(:name)
    if @main
      params[:q] ||= {}
      if params[:q][:year_eq].present?
        params[:q].merge!(entry_at_gteq: Date.new(params[:q][:year_eq].to_i, 1, 1))
        params[:q].merge!(entry_at_lteq: Date.new(params[:q][:year_eq].to_i, 12, 31))
      end
      @entries = @main.entries.ransack(params[:q]).result()
      @years = @main.entries.pluck(:entry_at).map{|x| x.year}.uniq
    end
  end
end
