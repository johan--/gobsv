class Employments::UserLanguage < ActiveRecord::Base
  belongs_to :user

  validates :name, :read, :write, :speak, presence: true
  validates :name, uniqueness: { scope: :user_id }


  # Según catalogos de la técnica
  Languages = {
    :english => "Inglés",
    :french => "Francés",
    :german => "Alemán",
    :italian => "Italiano",
    :czech => "Checo",
    :russian => "Ruso",
    :portuguese => "Portugués",
    :nahuatl => "Náhuatl"
  }
  Ability = {
    1 => "Regular",
    2 => "Bien"
  }
  def code
    case name
      when 'english'
        return '002'
      when 'french'
        return '003'
      when 'german'
        return '004'
      when 'italian'
        return '005'
      when 'czech'
        return '006'
      when 'russian'
        return '007'
      when 'portuguese'
        return '008'
      when 'nahuatl'
        return '009'
    end
  end

  def name_s
    Languages[name.to_sym] rescue ''
  end

end
