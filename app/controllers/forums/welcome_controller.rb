class Forums::WelcomeController < ForumsController
  def index
    @main = Forum::Theme.active.main.first
    if request.xhr? || request.format.js?
      @entries = @main.entries.ransack(params[:q]).result().paginate(page: params[:page], per_page: 5)
    else
      @medias = Forum::Organization.where(kind: 'media').order(:name)
      @politics = Forum::Organization.where(kind: 'politic').order(:name)
      if @main
        params[:q] ||= {}
        if params[:q][:year_eq].present?
          params[:q].merge!(entry_at_gteq: Date.new(params[:q][:year_eq].to_i, 1, 1))
          params[:q].merge!(entry_at_lteq: Date.new(params[:q][:year_eq].to_i, 12, 31))
        end
        @entries = @main.entries.ransack(params[:q]).result().paginate(page: params[:page], per_page: 5)
        @years = @main.entries.pluck(:entry_at).map{|x| x.year}.uniq
      end
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def download
    @main = Forum::Theme.active.main.first
    if @main.asset.present?
      @main.update_column(:asset_downloads, @main.asset_downloads + 1)
      file_location = @main.asset.path
      send_file file_location,
        :filename => @main.asset_file_name,
        :type => @main.asset_content_type,
        :disposition => 'inline'
    else
      redirect_to forums_root_url and return
    end
  end
end
