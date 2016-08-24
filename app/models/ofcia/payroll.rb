module Ofcia
  # Ofcia::Payroll
  class Payroll < ActiveRecord::Base
    attr_accessor :dates
    attr_accessor :start_date
    attr_accessor :end_date
    attr_accessor :economic_activity_ids
    attr_accessor :field

    belongs_to :payroll_patron

    scope :matrix_select, lambda { |field, counter|
      select("SUM(s#{counter}.#{field}) AS total_#{counter}")
    }

    scope :matrix_select_avg, lambda { |field, counter|
      select("SUM(s#{counter}.#{field.gsub('_avg', '')}) / 12 AS total_#{counter}")
    }

    scope :matrix_joins, lambda { |field, enconomic_activity, counter|
      joins("
        LEFT JOIN (
        	SELECT
        		ss1.id,
        		ss1.#{field.gsub('_avg', '')}
        	FROM ofcia_payrolls ss1
        	LEFT JOIN ofcia_payroll_patrons ss2
          ON (ss1.payroll_patron_id = ss2.id)
        	WHERE
        		ss2.payroll_economic_activity_id = #{enconomic_activity}
        ) s#{counter} ON (t1.id = s#{counter}.id)
      ")
    }

    scope :matrix_avg, lambda { |field, enconomic_activity_ids|
      scp = select('DATE_TRUNC(\'year\', t1.period_date)')
      scp = scp.from('ofcia_payrolls t1')
      enconomic_activity_ids.each_with_index do |enconomic_activity_id, index|
        scp = scp.matrix_select_avg(field, index)
        scp = scp.matrix_joins(field, enconomic_activity_id, index)
      end
      scp = scp.group('DATE_TRUNC(\'year\', t1.period_date)')
      scp.order('1')
    }

    scope :matrix, lambda { |field, enconomic_activity_ids|
      scp = select('t1.period_date')
      scp = scp.from('ofcia_payrolls t1')
      enconomic_activity_ids.each_with_index do |enconomic_activity_id, index|
        scp = scp.matrix_select(field, index)
        scp = scp.matrix_joins(field, enconomic_activity_id, index)
      end
      scp = scp.group('t1.period_date')
      scp.order('t1.period_date')
    }

    scope :matrix_dates, lambda { |start_date, end_date|
      where("t1.period_date BETWEEN '#{start_date}' AND '#{end_date}'")
    }

    def self.min_period
      minimum(:period_date)
    end

    def self.max_period
      maximum(:period_date)
    end

    def dates_from_range!
      batches = dates.split(' - ')
      self.start_date = Date.parse(batches.first)
      self.end_date   = Date.parse(batches.last)
    end
  end
end
