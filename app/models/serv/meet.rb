class Serv::Meet < ActiveRecord::Base

    belongs_to :admin

    scope :current, -> (t) {
       where('"serv_meets"."start" <= ?', t)
      .where('"serv_meets"."end"   >  ?', t)
    }

    scope :current_week, -> (t) {
       where('"serv_meets"."start" >= ?', t)
      .where('"serv_meets"."end"   <= ?', t + 1.weeks)
    }

    def self.week(room_id, year, month, day, hour, minute)
      t = Time.zone.local(year, month, day, hour, minute, 0)
      current_week(t).where(room_id: room_id)
    end

    def self.booking(admin, room_id, year, month, day, hour, minute)
      t = Time.zone.local(year, month, day, hour, minute, 0)
      o = current(t).where(room_id: room_id).first

      return new(admin_id: admin.id, room_id: room_id, start: t) if o.nil?
      o
    end

    def next_at
      Serv::Meet
        .where('"serv_meets"."room_id" =  ?', room_id)
        .where('"serv_meets"."start"   >  ?', start)
        .where('"serv_meets"."start"   <= ?', start.end_of_day)
        .order(:start)
        .first
        .try(:start)
    end

    def as_json(options = {})
      super
        .merge(
          next_at: next_at
        )
        .merge(options)
    end
end
