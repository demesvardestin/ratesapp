class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :update
    before_action :authenticate_user!, except: [:show]
    # before_action :setup_instagram, only: :auth_connect
    # CALLBACK_URL = "https://action-cable-chat-demo07.c9users.io:8080/oauth/callback"
    
    def show
        if !current_user
            @promoter = User.find_by(username: params[:username]) || User.new(username: params[:username])
        else
            @promoter = current_user
        end
        
        @promo = Promo.new
        @promos = @promoter.promos.limit(8)
        
        # @comment = Comment.new
        # @comments = Comment.where(promoter_id: @promoter.id).order('created_at DESC')
    end
    
    def payouts
        @promoter = current_user
    end
    
    def edit
        @promoter = current_user
    end
    
    def update
        @promoter = current_user
        @promoter.update!(user_params)
        
        respond_to do |format|
            format.html { redirect_to account_settings_path, notice: "Account settings updated!" }
        end
    end
    
    def promo_requests
        @requests = current_user.promos.map(&:promo_requests)
    end
    
    def update_notification_watcher
        if !current_user.notification_watcher.checked
            current_user.notification_watcher.update(checked: true)
        end
    end
    
    def update_all_notifications
        current_user.promo_requests.unseen.each {|r| r.update(seen: true) }
    end
    
    # FUTURE IMPLEMENTATION
    # def auth_connect
    #     session[:claimed_acct] = params[:username]
    #     CALLBACK_URL << "?username=#{params[:username]}"
    #     redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
    # end
    
    # def auth_callback
    #     response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
    #     session[:access_token] = response.access_token
    #     session[:username] = response.user.username
        
    #     redirect_to new_user_registration_path(:username => session[:claimed_acct])
    # end
    
    private
    
    def user_params
        params.require(:user).permit(:username, :image)
    end
    
    # def setup_instagram
    #     Instagram.configure do |config|
    #         config.client_id = ""
    #         config.client_secret = ""
    #     end
    # end
    
end
