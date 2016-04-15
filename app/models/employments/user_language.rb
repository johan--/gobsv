class Employments::UserLanguage < ActiveRecord::Base
  belongs_to :user

  validates :name, :read, :write, :speak, presence: true

  Languages = {
    :english => "Inglés",
    :french => "Francés",
    :german => "Alemán",
    :portuguese => "Portugués",
    :italian => "Italiano",
    :russian => "Ruso",
    :nahuatl => "Náhuatl"
  }

  Ability = {
    1 => "Regular",
    2 => "Bien"
  }

end
