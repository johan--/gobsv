class Forums::WelcomeController < ForumsController
  def index
    @main = Forum::Theme.active.main.first
    @medias = Forum::Organization.where(kind: 'media').order(:name)
    @politics = Forum::Organization.where(kind: 'politic').order(:name)
    if @main
      search = {}
      if params[:q]
        organization_ids = [params[:q][:media_id], params[:q][:political_id]]
        organization_ids.reject!{|a| a==""}
        unless organization_ids.blank?
          search[:organization_id_in] = organization_ids
        end
        if params[:q][:year_eq].present?
          search[:entry_at_gteq] = Date.new(params[:q][:year_eq].to_i, 1, 1)
          search[:entry_at_lteq] = Date.new(params[:q][:year_eq].to_i, 12, 31)
        end
        case params[:q][:kind_eq].to_s
          when 'Twitter'
            search[:kind_eq] = 'twitter'
        end
      end
      @entries = @main.entries.ransack(search).result()
      @years = @main.entries.pluck(:entry_at).map{|x| x.year}.uniq
    end
  end
end
