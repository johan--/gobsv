class Indicators::GeneralController < IndicatorsController

  def index
    if params[:category].nil?
      redirect_to indicators_root_url and return
    end
    @indicator_category = ::Ind::Category.find(params[:category])
    @note_kinds = ::Ind::Note.where("category_id = ? AND note_kind_id IN (?)", @indicator_category.id, ::Ind::NoteKind.all.map(&:id)).map{|note| note.note_kind}.uniq
  end

  def show
    @indicator = ::Ind::Note.find params[:id]
  end

  def about
    
  end

end