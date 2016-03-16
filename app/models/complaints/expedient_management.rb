class Complaints::ExpedientManagement < ActiveRecord::Base
  belongs_to :admin
  belongs_to :expedient, class_name: '::Complaints::Expedient'
  has_many :events, class_name: '::Complaints::ExpedientManagementEvent', dependent: :destroy
  has_many :comments, class_name: '::Complaints::ExpedientManagementComment', dependent: :destroy
  has_and_belongs_to_many :assets,
    join_table: :complaints_expedient_managements_complaints_assets,
    class_name: '::Complaints::Asset',
    foreign_key: 'complaints_expedient_management_id',
    association_foreign_key: 'complaints_asset_id'

  validates :kind, :comment, presence: true

  scope :newer, -> { order(created_at: :desc) }
  scope :closed, -> { where(status: 'closed') }
  scope :news, -> { where(status: 'new') }
  scope :kind, -> (kind) { where(kind: kind) }


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

  def hours_passed
    ((Time.current - created_at) / 1.hour).round
  end
end
