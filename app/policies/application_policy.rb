class ApplicationPolicy
  attr_reader :admin, :record

  def initialize(admin, record)
    @admin = admin
    @record = record
  end

  def admin_activities
    @admin.role.try(:activities) || []
  end

  def inferred_activity(method)
    "#{@record.class.name.downcase}:#{method.to_s}"
  end

  def method_missing(name,*args)
    if name.to_s.last == '?'
      admin_activities.include?(inferred_activity(name.to_s.gsub('?','')))
    else
      super
    end
  end

  def scope
    Pundit.policy_scope!(admin, record.class)
  end
end
