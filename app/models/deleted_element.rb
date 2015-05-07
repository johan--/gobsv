class DeletedElement < PaperTrail::Version

  default_scope { where(event: 'destroy') }

  def hash_object
    HashWithIndifferentAccess.new(YAML.load(object))
  end

  def as_json(options = {})
    super.as_json(options).merge(
      object_name: object.name,
      created_at: I18n.l(created_at, format: :short),
      item_type: I18n.t("activerecord.models.#{item_type.underscore}"),
      object: hash_object
    )
  end
end
