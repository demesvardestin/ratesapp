class PromoRequestsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :optional_payment_path]
  
  def new
    @request = PromoRequest.new
    @promoter = User.find_by(username: params[:promoter])
  end

  def create
    @request = PromoRequest.new(requests_params)
    @request.shipped = true
    
    respond_to do |format|
      if @request.save
        format.html { redirect_to request_receipt_path(:request_id => @request.token) }
        RequestMailer.send_request(@request).deliver_now
        RequestMailer.send_confirmation(@request).deliver_now
      else
        @promoter = Promo.find(@request.promo_id).user
        format.html { render :new, :promoter => @promoter.username, :promo_id => @request.promo_id }
      end
    end
  end
  
  def receipt
    @request = PromoRequest.find_by(token: params[:request_id])
    @promoter = @request.promo.user
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
    send_file "#{Rails.root}/public#{@request.image.url}", type: "image/png", x_sendfile: true
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
  
  ## Future payment integration
  # def optional_payment
  #   @request = PromoRequest.find_by(token: params[:request_token])
  # end
  
  # def ship_request
  #   @request = PromoRequest.find_by(token: params[:request_id])
  #   if @request.nil?
  #     redirect_to not_found_path
  #     return
  #   end
    
  #   @request.update(shipped: true)
  #   redirect_to request_receipt_path(:request_id => @request.token)
  # end
  
  ## Promoter email
  #
  # def send_email
  #   @promoter = current_user
  #   @request = @promoter.promo_requests.find_by(token: params[:request_id])
  #   @content = params[:email_content]
    
  #   @notice = "Email sent!"
  #   render :layout => false
    
  #   RequestMailer.send_promoter_email(@promoter, @request, @content).deliver_now
  # end
  
  private
  
  def requests_params
    params.require(:promo_request).permit(:image, :video_link, :audio_link,
      :website_link, :hashtags, :caption, :additional_notes, :promo_id, :client_email,
      :social_platform)
  end
end
