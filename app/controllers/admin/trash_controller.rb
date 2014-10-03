class Admin::TrashController < Admin::TabledController

  def model
    DeletedElement
  end

  def restore
    version = model.find params[:id]
    record = version.reify
    if record.save
      version.destroy
    end
    redirect_to url_for(action: :index), notice: t('layouts.admin.notice.restored')
  end

end
