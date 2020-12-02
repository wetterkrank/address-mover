class PdfsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  def show
    skip_authorization

    @pdf = PDF.find_by(uuid: params[:uuid])
    raise ActionController::RoutingError.new('Not Found') if @pdf.nil?

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Address Change Notification",
               margin: { top: 20, bottom: 25, left: 25, right: 20 } # in mm
              #  disposition: 'attachment' # default 'inline'
      end
    end
  end
end