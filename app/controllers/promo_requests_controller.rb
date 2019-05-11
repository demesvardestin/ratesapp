class PromoRequestsController < ApplicationController
  
  def new
    @request = PromoRequest.new
    @promoter = User.find_by(username: params[:promoter])
  end

  def create
    @request = PromoRequest.new(requests_params)
    # @request.brand = current_brand
    
    respond_to do |format|
      if @request.save
        format.html { redirect_to confirmation_receipt_path(:request_id => @request.token) }
        RequestMailer.send_request(@request).deliver_now
      else
        @promoter = Promo.find(@request.promo_id).user
        format.html { render :new, :promoter => @promoter.username, :promo_id => @request.promo_id }
      end
    end
  end

  def show
    @request = PromoRequest.find_by(token: params[:id])
    @promoter = @request.promo.user
    
    if @request.brand != current_brand
      redirect_to :back
    end
  end
  
  def receipt
    @request = PromoRequest.find_by(token: params[:request_id])
    @promoter = @request.promo.user
  end
  
  private
  
  def requests_params
    params.require(:promo_request).permit(:image, :video_link, :audio_link,
      :website_link, :hashtags, :caption, :additional_notes, :promo_id, :client_email)
  end
end
