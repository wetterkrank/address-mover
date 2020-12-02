class PdfsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  def show
    skip_authorization

    @pdf = PDF.find_by(uuid: params[:uuid])
    raise ActionController::RoutingError.new('Not Found') if @pdf.nil?

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Address Change Notification"   # Excluding ".pdf" extension.
      end
    end
  end
end