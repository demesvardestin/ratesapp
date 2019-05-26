class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:update, :set_email_preferences]
    before_action :authenticate_user!, except: [:show]
    
    def show
        @promoter = User.find_by(username_display: params[:username].downcase)
        
        if @promoter.nil?
            redirect_to "/404"
            return
        end
        
        @promos = @promoter.promos
    end
    
    def dashboard
        @promoter = current_user
        
        @promo = Promo.new
        @promos = @promoter.promos
        
        if mobile_device?
            flash[:notice] = "Note: Adding and editing your rates is better handled on a desktop"
        end
    end
    
    def payouts
        @promoter = current_user
    end
    
    def edit
        @promoter = current_user
        @promo = @promoter.promos.first
    end
    
    def set_email_preferences
        @promoter = current_user
        promotional_sub_status = case params[:promo_email].strip.downcase
            when 'subscribe'
                false
            when 'unsubscribe'
                true
            else
                @promoter.unsubscribed_from_promotional_emails
        end
        
        general_sub_status = case params[:unsubscribe].strip.downcase
            when 'subscribe'
                false
            when 'unsubscribe'
                true
            else
                @promoter.unsubscribed_from_email
        end
        
        @promoter.update(unsubscribed_from_email: general_sub_status,
            unsubscribed_from_promotional_emails: promotional_sub_status)
            
        redirect_to :back, notice: "Account details updated!"
    end
    
    def update
        @promoter = current_user
        if params[:user][:cashapp_link]
            params[:user][:cashapp_link] = params[:user][:cashapp_link].split('$').join('')
        end
        
        begin
            @promoter.update!(user_params)
            redirect_to :back, notice: "Account settings updated!"
        rescue ActiveRecord::RecordInvalid => e
            redirect_to :back, notice: e
        end
    end
    
    def promo_requests
        @requests = current_user.promo_requests.order('created_at DESC').paginate(page: params[:page], per_page: 10)
    end
    
    def update_all_notifications
        current_user.promo_requests.unseen.each {|r| r.update(seen: true) }
    end
    
    private
    
    def user_params
        params.require(:user).permit(:username, :image, :theme_color, :background_image,
            :paypal_link, :cashapp_link, :username_display)
    end
    
    def mobile_device?
        if session[:mobile_param]
            session[:mobile_param] == "1"
        else
            request.user_agent =~ /Mobile|webOS/
        end
    end
    
end
