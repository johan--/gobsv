# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ofcia_payroll, :class => 'Ofcia::Payroll' do
    periodo "MyString"
    id_causa_complemento 1
    tasa_cotiz_lab_ivm "9.99"
    impresa 1
    tipo_mora 1
    maximo_cotizable_fsv "9.99"
    correlativo_centro_trabajo 1
    cambio_nota_detalle 1
    id_usuario "MyString"
    correlativo_original_migracion 1
    id_codigo_observacion 1
    id_sucursal 1
    aporte_pat_ivm "9.99"
    horas 1
    tasa_cotiz_pat_ivm "9.99"
    tasa_cotiz_pat_fsv "9.99"
    maximo_cotizable "9.99"
    aporte_patronal "9.99"
    monto_vacacion "9.99"
    monto_salario "9.99"
    id_tipo_pago_planilla 1
    aporte_total_ivm "9.99"
    aporte_total "9.99"
    id_estado_planilla 1
    tasa_cotiz_laboral "9.99"
    monto_pago_adicional "9.99"
    id_tipo_planilla 1
    aporte_total_fsv "9.99"
    aporte_lab_fsv "9.99"
    cambio_nota 1
    aporte_laboral "9.99"
    tasa_cotiz_patronal "9.99"
    no_afiliacion_trabajador "MyString"
    mecanizada 1
    tasa_cotiz_lab_fsv "9.99"
    dias 1
    no_patronal "MyString"
    maximo_cotizable_ivm "9.99"
    fecha_presentacion_planilla "2016-06-13"
    id_procesamiento "MyString"
    aporte_lab_ivm "9.99"
    grupo_recepcion 1
    aporte_pat_fsv "9.99"
    complementaria 1
    correlativo_empleado 1
    dias_vacacion 1
    tipo_procesamiento 1
  end
end
