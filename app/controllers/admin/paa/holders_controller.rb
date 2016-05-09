class Admin::Paa::HoldersController < Admin::PaaController

  def model
    ::Paa::Holder
  end

  def index
    #@items = model.select(table_columns + [:id]).where(conditions).decorate
    #@items = ::Paa::Saving.joins([:financial_source]).select("paa_financial_sources.name, paa_savings.id").decorate
    items_ = ::Paa::Saving.joins([:institution]).select("institutions.name, paa_savings.*")
    @items = []

    items_.to_a.group_by(&:name).each do |name, fields|
      fields.group_by{|f| [f.start_at, f.end_at]}.each do |date, fieldss|
        @items << {name: name, year: get_year(date[0], date[1]), trimester: get_trimester(date[0], date[1]), id: fieldss.map(&:id)}
      end
    end

    #@items = []    
    #items_.to_a.group_by(&:name).each do |name, id|
    #  @items << {name: name, id: id.map(&:id)}
    #end
    
    #::Paa::Saving.joins([:financial_source]).group([:id], [:institution_id]).select([:id])


    add_breadcrumb model.model_name.human(count: :many), index_url

    respond_to do |format|
      format.html { render template: 'admin/paa/holders/index' }
      format.json { render json: @items }
    end
  end

  def table_columns
    %w(name, id)
  end

  def init_form
  end

  def item_params
    #params.require(:paa_holder).permit(    )
  end

  def get_year(start_at, end_at)

    r = nil
    if !start_at.nil? and !end_at.nil?
      start_year = start_at.strftime("%Y").to_i
      end_year   = end_at.strftime("%Y").to_i
      
      if start_year == end_year
        y = start_year
        r = y
      end
    end
    r
  end
  
  def get_trimester(start_at, end_at)
    r = nil
    if !start_at.nil? and !end_at.nil?
      start_year = start_at.strftime("%Y").to_i
      end_year   = end_at.strftime("%Y").to_i
      
      if start_year == end_year
        start_month = start_at.strftime("%m").to_i 
        end_month   = end_at.strftime("%m").to_i
        
        if start_month == 1 and end_month == 3
          m = 1
        end
        
        if start_month == 4 and end_month == 6
          m = 2
        end
        
        if start_month == 7 and end_month == 9
          m = 3
        end
        
        if start_month == 10 and end_month == 12
          m = 4
        end
        
        r = m
      end
    end
    r
  end

end
