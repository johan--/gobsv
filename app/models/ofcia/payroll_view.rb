module Ofcia
  # Ofcia::PayrollView uses a postgresql
  class PayrollView < ActiveRecord::Base
    self.table_name = 'ofcia_payroll_view'

    attr_accessor :rows

    def initialize(attributes = {}, options = {})
      super(attributes, options)
      self.rows = []
    end

    def self.filter_attrs
      [
        :sector_id,
        :economic_activity_group_id,
        :economic_activity_id
      ]
    end

    def self.prev_attr(attr)
      i = filter_attrs.find_index(attr) - 1
      i > -1 ? filter_attrs[i] : nil
    end

    def self.next_attr(attr = nil)
      return :sector_id if attr.nil?
      i = filter_attrs.find_index(attr) + 1
      filter_attrs[i]
    end

    def self.id2name(id)
      data = {
        sector_id: :sector_name,
        economic_activity_group_id: :economic_activity_group_name,
        economic_activity_id: :economic_activity_name
      }
      return data[id] if data.key?(id)
      id
    end

    def self.grouped(attr)
      group(attr, id2name(attr)).count.to_a.map(&:flatten).map do |z|
        o = {
          row: {
            level: filter_attrs.find_index(attr),
            name: z.second, count: z.last
          },
          conditions: { attr => z.first }
        }
        o
      end
    end

    def rows!(conditions = {}, attr = :sector_id)
      conditions = conds if conditions.empty?
      self.class.where(conditions).grouped(attr).each do |group|
        rows << group[:row]
        cond = conditions.merge(group[:conditions])
        next_attr = self.class.next_attr(attr)
        rows!(cond, next_attr) unless next_attr.nil?
      end
    end

    def conds
      w = {}
      fields = self.class.filter_attrs + [:year, :month]
      fields.each do |attr|
        w[attr] = send(attr) unless send(attr).blank?
      end
      w
    end
  end
end
