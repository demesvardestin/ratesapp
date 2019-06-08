class UsersController < ApplicationController
    include StripeProcessor
    
    skip_before_action :verify_authenticity_token, only: [
        :update,
        :set_email_preferences,
        :add_stripe_account,
        :set_payout_method,
        :stripe_callback
    ]
    before_action :authenticate_user!, except: [:show, :stripe_callback]
    
    def show
        @promoter = User.find_by(username_display: params[:username].downcase)
        
        if !@promoter.nil?
            @promos = @promoter.promos
        end
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
    
    def stripe_callback
        type = params[:type]
        
        case type
        when 'account.updated'
            account_updated type, params
        when 'account.external_account.created' || 'account.external_account.updated'
            user, body = external_account type, params
            RequestMailer.send_stripe_alert_to(user, "Debit Card Verified!", body).deliver_now
        when 'payout.created'
            payout_created type, params
        when 'payout.paid'
            user, body = payout_paid type, params
            RequestMailer.send_stripe_alert_to(user, "Your Payout Is On The Way!", body).deliver_now
        when 'payout.failed'
            user, body = payout_failed type, params
            RequestMailer.send_stripe_alert_to(user, "Payout Issues", body).deliver_now
        when 'account.application.deauthorized'
            application_deauthorized type, params
        else
            catch_all type, params
        end
    end
    
    def earnings
        @promos = current_user.promo_requests
                    .paid.paginate(page: params[:page], per_page: 10)
                    .order('created_at DESC')
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
        
        @promoter.update(
            unsubscribed_from_email: general_sub_status,
            unsubscribed_from_promotional_emails: promotional_sub_status
        )
            
        redirect_to :back, notice: "Account details updated!"
    end
    
    def set_payout_method
        method = params[:method]
        current_user.update(preferred_payout_method: method)
        
        redirect_to :back, notice: 'Your preferred payout method has been set!'
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
        @requests = current_user.promo_requests.order('created_at DESC')
                    .paginate(page: params[:page], per_page: 10)
    end
    
    def update_all_notifications
        current_user.promo_requests.unseen.each {|r| r.update(seen: true) }
    end
    
    def add_stripe_account
        begin
            acct = fetch_or_create_account_for(
                current_user,
                params[:stripe_token],
                params[:line1],
                params[:city],
                params[:state],
                params[:postal_code],
                params[:phone],
                params[:dob],
                params[:ssn_last_4]
            )
            current_user.update(stripe_token: acct.id, stripe_external_account_verified: false)
            redirect_to :back, notice: "Your card has been added and is pending verification"
        rescue Stripe::StripeError => e
            body = e.json_body
            err = body[:error]
            message = err[:message]
            
            redirect_to :back, notice: "#{message}. Error: #{err[:code]}. Status: #{e.http_status}"
            return
        end
    end
    
    private
    
    def user_params
        params
        .require(:user)
        .permit(
            :username,
            :image,
            :theme_color,
            :background_image,
            :paypal_link,
            :cashapp_link,
            :username_display,
            :first_name,
            :last_name
        )
    end
    
    def mobile_device?
        if session[:mobile_param]
            session[:mobile_param] == "1"
        else
            request.user_agent =~ /Mobile|webOS/
        end
    end
    
end
