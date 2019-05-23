class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :update
    before_action :authenticate_user!, except: [:show]
    
    def show
        @promoter = User.find_by(username: params[:username])
        
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
    end
    
    def payouts
        @promoter = current_user
    end
    
    def edit
        @promoter = current_user
        @promo = @promoter.promos.first
    end
    
    def update
        @promoter = current_user
        begin
            @promoter.update!(user_params)
            redirect_to account_settings_path, notice: "Account settings updated!"
        rescue ActiveRecord::RecordInvalid => e
            redirect_to account_settings_path, notice: e
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
        params.require(:user).permit(:username, :image, :theme_color, :background_image)
    end
    
end
