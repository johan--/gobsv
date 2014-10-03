ActionView::Base.class_eval do
  def translate(key, options = {})
    super(key, options.merge({ cascade: { skip_root: false } }))
  end
  alias t translate
end
