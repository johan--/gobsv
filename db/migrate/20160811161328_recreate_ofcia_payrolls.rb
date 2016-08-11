class RecreateOfciaPayrolls < ActiveRecord::Migration
  def up
    drop_table :ofcia_payrolls
    create_table :ofcia_payrolls do |t|
      t.string :period
      t.date :period_date
      t.references :payroll_patron, index: true
      t.integer :total_up, default: 0
      t.decimal :amount_up, precision: 12, scale: 2, default: 0.0
      t.integer :total_down, default: 0, default: 0.0
      t.decimal :amount_down, precision: 12, scale: 2
      t.integer :total_pensioned, default: 0
      t.integer :total_contributors, default: 0
      t.integer :total, default: 0
      t.decimal :amount_total, precision: 12, scale: 2
      t.timestamps null: false
    end
  end

  def down
    drop_table :ofcia_payrolls
    create_table :ofcia_payrolls do |t|
      t.string :periodo
      t.integer :id_causa_complemento
      t.decimal :tasa_cotiz_lab_ivm, precision: 9, scale: 3
      t.integer :impresa
      t.integer :tipo_mora
      t.decimal :maximo_cotizable_fsv, precision: 9, scale: 3
      t.integer :correlativo_centro_trabajo
      t.integer :cambio_nota_detalle
      t.string :id_usuario
      t.integer :correlativo_original_migracion
      t.integer :id_codigo_observacion
      t.integer :id_sucursal
      t.decimal :aporte_pat_ivm, precision: 9, scale: 3
      t.integer :horas
      t.decimal :tasa_cotiz_pat_ivm, precision: 9, scale: 3
      t.decimal :tasa_cotiz_pat_fsv, precision: 9, scale: 3
      t.decimal :maximo_cotizable, precision: 9, scale: 3
      t.decimal :aporte_patronal, precision: 9, scale: 3
      t.decimal :monto_vacacion, precision: 9, scale: 3
      t.decimal :monto_salario, precision: 9, scale: 3
      t.integer :id_tipo_pago_planilla
      t.decimal :aporte_total_ivm, precision: 9, scale: 3
      t.decimal :aporte_total, precision: 9, scale: 3
      t.integer :id_estado_planilla
      t.decimal :tasa_cotiz_laboral, precision: 9, scale: 3
      t.decimal :monto_pago_adicional, precision: 9, scale: 3
      t.integer :id_tipo_planilla
      t.decimal :aporte_total_fsv, precision: 9, scale: 3
      t.decimal :aporte_lab_fsv, precision: 9, scale: 3
      t.integer :cambio_nota
      t.decimal :aporte_laboral, precision: 9, scale: 3
      t.decimal :tasa_cotiz_patronal, precision: 9, scale: 3
      t.string :no_afiliacion_trabajador
      t.integer :mecanizada
      t.decimal :tasa_cotiz_lab_fsv, precision: 9, scale: 3
      t.integer :dias
      t.string :no_patronal
      t.decimal :maximo_cotizable_ivm, precision: 9, scale: 3
      t.date :fecha_presentacion_planilla
      t.string :id_procesamiento
      t.decimal :aporte_lab_ivm, precision: 9, scale: 3
      t.integer :grupo_recepcion
      t.decimal :aporte_pat_fsv, precision: 9, scale: 3
      t.integer :complementaria
      t.integer :correlativo_empleado
      t.integer :dias_vacacion
      t.integer :tipo_procesamiento

      t.timestamps null: false
    end
  end
end
