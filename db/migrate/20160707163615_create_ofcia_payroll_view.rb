class CreateOfciaPayrollView < ActiveRecord::Migration
  def up
    execute '
      CREATE VIEW
      	ofcia_payroll_view
      AS
      SELECT
      	SUBSTRING(t1.periodo, 1, 4)::integer AS year,
      	substring(t1.periodo, 5, 2)::integer AS month,
      	t1.monto_salario AS salary,
      	t1.no_patronal AS patronal_number,
      	t2.name AS patron_name,
      	t2.economic_activity_id,
      	t3.name AS economic_activity_name,
      	t4.id AS economic_activity_group_id,
      	t4.name AS economic_activity_group_name,
      	t2.sector_id,
      	t5.name AS sector_name
      FROM ofcia_payrolls t1
      LEFT JOIN ofcia_payroll_patrons t2 ON (t1.no_patronal = t2.employer_id)
      LEFT JOIN ofcia_payroll_economic_activities t3 ON (t2.economic_activity_id = t3.id)
      LEFT JOIN ofcia_payroll_economic_activity_groups t4 ON (t3.economic_activity_group = t4.id)
      LEFT JOIN ofcia_payroll_sectors t5 ON (t2.sector_id = t5.id)
    '
  end

  def down
    execute 'DROP VIEW ofcia_payroll_view'
  end
end
