class PromoRequestsController < ApplicationController
  include StripeProcessor
  before_action :authenticate_user!, only: [:show, :optional_payment_path]
  skip_before_action :verify_authenticity_token, only: :pay
  
  def new
    @request = PromoRequest.new
    @promoter = User.find_by(username: params[:promoter])
  end

  def create
    @request = PromoRequest.new(requests_params)
    @request.shipped = true
    @promoter = Promo.find(@request.promo_id).user
    
    respond_to do |format|
      if @request.save
        case @promoter.preferred_payout_method
        when 'debit'
          format.html { redirect_to request_payment_path(:request_id => @request.token) }
        else
          @request.update(direct_payment: false)
          format.html { redirect_to request_receipt_path(:request_id => @request.token) }
        end
      else
        format.html { render :new, :promoter => @promoter.username, :promo_id => @request.promo_id }
      end
    end
  end
  
  def payment
    @request = PromoRequest.find_by(token: params[:request_id])
    @promoter = @request.promo.user
    @cost = StripeProcessor.calculate_application_fee @request.promo.package_price
  end
  
  def pay
    @request = PromoRequest.find_by(token: params[:request_id])
    @promoter = @request.promo.user
    token = params[:stripe_token]
    
    begin
      charge = process_payment(@request.promo.package_price, token, @promoter)
      @request.update(paid: true, stripe_charge_id: charge.id, direct_payment: true)
    rescue
      redirect_to :back, notice: "Something happened while processing your payment. Please try again."
      return
    end
    
    redirect_to request_receipt_path(:request_id => @request.token), notice: "Your request has been successfully processed!"
    
    process_payout_for(@promoter)
    
    RequestMailer.send_payment_receipt_to_client(@request).deliver_now
    RequestMailer.send_payment_receipt_to_promoter(@request).deliver_now
  end
  
  def receipt
    @request = PromoRequest.find_by(token: params[:request_id])
    @promoter = @request.promo.user
    
    RequestMailer.send_request(@request).deliver_now
    RequestMailer.send_confirmation(@request).deliver_now
  end
  
  def mark_as_processed
    @request = PromoRequest.find_by(token: params[:request_id])
    @request.update(complete: true)
    
    redirect_to :back, notice: "Request marked as processed!"
  end

  def show
    @request = PromoRequest.find_by(token: params[:id])
    @promoter = @request.promo.user
    
    if @promoter != current_user
      redirect_to :back, notice: "Oops, looks like you cannot access this page"
    end
    
    if !@request.seen
      @request.update(seen: true)
    end
  end
  
  def download_image
    @request = PromoRequest.find_by(token: params[:request_id])
    send_file "#{@request.image.url}", type: "image/png", x_sendfile: true
  end
  
  def processed
    @requests = current_user.promo_requests.completed.order('created_at DESC')
    # .paginate(page: params[:page], per_page: 10)
    
    render :layout => false
  end
  
  def unprocessed
    @requests = current_user.promo_requests.incomplete.order('created_at DESC')
    # .paginate(page: params[:page], per_page: 10)
    
    render :layout => false
  end
  
  def all
    @requests = current_user.promo_requests.order('created_at DESC')
    # .paginate(page: params[:page], per_page: 10)
    
    render :layout => false
  end
  
  private
  
  def requests_params
    params.require(:promo_request).permit(:image, :video_link, :audio_link,
      :website_link, :hashtags, :caption, :additional_notes, :promo_id, :client_email,
      :social_platform)
  end
end
