require_relative '20160704153218_create_ofcia_payroll_types'
require_relative '20160704161143_create_ofcia_payroll_statuses'
require_relative '20160704162110_create_ofcia_payroll_sectors'
require_relative '20160704162848_create_ofcia_payroll_observation_codes'
require_relative '20160707161054_create_ofcia_payroll_economic_activity_groups'
require_relative '20160707163615_create_ofcia_payroll_view'


class RevertUnusedOfciaPayrollMigrations < ActiveRecord::Migration
  def change
    revert CreateOfciaPayrollTypes
    revert CreateOfciaPayrollStatuses
    revert CreateOfciaPayrollObservationCodes
    revert CreateOfciaPayrollView
    revert CreateOfciaPayrollEconomicActivityGroups
    revert CreateOfciaPayrollSectors
  end
end
