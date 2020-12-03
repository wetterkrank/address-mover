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
               #disposition: 'attachment', # default 'inline'
               margin: { top: 20, bottom: 25, left: 25, right: 20 }
      end
    end
  end

  def mail
    @pdf = PDF.find_by(uuid: params[:uuid])
    raise ActionController::RoutingError.new('Not Found') if @pdf.nil?
    authorize @pdf

    LetterSendJob.set(wait: 5.seconds).perform_later(@pdf.parent)
    SmsSendJob.set(wait: 5.seconds).perform_later(@pdf.parent)

    redirect_to my_providers_path, notice: "We're sending the letter to #{@pdf.parent.provider.name}, please check the status later."
  end
end
