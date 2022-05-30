module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue from StandardError, with: :rescue500
    rescue from ApplicationController::Forbidden, with: :rescue403
    rescue from ApplicationController::IpAddressRejected, with: :rescue403
    rescue from ActiveRecord::RecordNotFound, with: :rescue404
  end

  private 
  
  def rescue403(e)
    @exception = e
    render "errors/forbidden", status: 403
  end

  def rescue404(e)
    render "errors/not found", status: 404
  end

  def rescue500(e)
    render "errors/internal server error", status: 500
  end
end


