class Complaints::ExpedientManagement < ActiveRecord::Base
  belongs_to :admin
  has_many :events, class_name: '::Complaints::ExpedientManagementEvent', dependent: :destroy
  has_many :comments, class_name: '::Complaints::ExpedientManagementComment', dependent: :destroy

  validates :kind, :comment, presence: true

  scope :newer, -> { order(created_at: :desc) }

  KIND = {
    'notice' => 'Aviso',
    'comment' => 'Comentario',
    'query' => 'Consulta',
    'complaint' => 'Denuncia',
    'request' => 'Petición',
    'complaint' => 'Queja'
  }

  CLOSED_AS = {
    'delivery' => 'Cerrada y entregada',
    'complexity' => 'Cerrada por complejidad',
    'redirected' => 'Cerrada y redireccionada',
    'duplicity' => 'Cerrada por duplicidad',
    'comment' => 'Cerrada por comentario'
  }

  def assigned_names
    @assigned_names ||= Admin.where(id: assigned_ids).pluck(:name).join(', ')
  end

  def kind_s
    KIND[self.kind]
  end

  def closed_as_s
    CLOSED_AS[self.closed_as]
  end

  def new?
    status == 'new'
  end

  def process?
    status == 'process'
  end

  def closed?
    status == 'closed'
  end
end
