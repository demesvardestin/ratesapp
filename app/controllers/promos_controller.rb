class PromosController < ApplicationController
    before_action :authenticate_user!
    
    def create
        @promo = Promo.new(promo_params)
        @promoter = current_user
        @promo.user = @promoter
        @promo.package_type = @promo.package_type.downcase
        
        respond_to do |format|
            if @promo.save
                @promos = current_user.promos
                format.js { render :layout => false }
            else
                format.js { render "error", :layout => false }
            end
        end
    end
    
    def edit
        @promo = Promo.find(params[:id])
        if @promo.user != current_user
            redirect_to root_path
        end
    end
    
    def update
        @promo = Promo.find(params[:id])
        @promo.update(promo_params)
        
        respond_to do |format|
            if @promo.save
                format.html { redirect_to root_path, notice: "Package details updated!" }
            end
        end
    end
    
    private
    
    def promo_params
        params.require(:promo).permit(:package_type, :package_price, :package_details)
    end
end