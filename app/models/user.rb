class User < ApplicationRecord
    mount_uploader :image, ImageUploader
    validates :image, file_size: { less_than: 20.megabytes }
    
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
    
    before_create { self.claimed = true }
    before_create { self.username_display = self.username.downcase }
    after_create { send_welcome_email }
    
    validates_uniqueness_of :username, :email, :username_display
    has_many :promos
    has_many :promo_requests, through: :promos
    
    def payout_links
        links = []
        links << { :service => "paypal", :link => "paypal.me/#{paypal_link}", :icon => "fab fa-paypal" } if paypal_link.present?
        links << { :service => "cashapp", :link => "cash.me/#{cashapp_link}", :icon => "fas fa-dollar-sign" } if cashapp_link.present?
        
        return links
    end
    
    ## GLOBAL SEARCH
    ##
    ## Summary:
    ## A parameter can optionally be passed, denoting the type of
    ## promoter the user is looking for. This returns a list of profiles matching
    ## the search.
    ##
    ## Load time and latency issues:
    ## With this current setup, search takes upwards of 30 seconds. Will need to
    ## to load results in batches. Load a first batch of 15 to be made available
    ## for viewing right away, then load rest in the background while user
    ## browses. Everytime user reaches end of list and clicks 'load more', 15
    ## additional results gets loaded out the cache until results list is
    ## exhausted.
    # def self.search(param='dm+for+promo')
    #     noko_array = html(param)
    #                 .css("body #{9.times.map {|i| "div" }
    #                 .join(" ")} ul li div div div a span").take(10)
    #                 .map {|i| i.content.to_i == 0 ? i.content : '' }
    #     results = noko_array.map {|a| User.new(a).profile if a.length > 0 }
    #     results
    # end
    # 
    # def self.html(username)
    #     Nokogiri::HTML(open("https://instagram.com/" + username))
    # end
    # 
    ## Get profile stats (followers, following, posts).
    ## This method needs to be refined, as the hash returned has inversed
    ## duplicates and nil values.
    # def profile
    #     document = User.html(username).css('script')
    #     script_array = document.select {|i| i.content.include?("follow") }.map {|s| s.content }
    #     script_content = script_array.last
    #     script_content_json = JSON.parse(script_content.split("window._sharedData = ").last.delete(';'))
    #     user_data = script_content_json["entry_data"]["ProfilePage"][0]["graphql"]["user"]
    #     user_data
    # end
    # 
    # def posts
    #     profile["edge_owner_to_timeline_media"]["count"]
    # end
    # 
    # def followers
    #     profile["edge_followed_by"]["count"]
    # end
    # 
    # def following
    #     profile["edge_follow"]["count"]
    # end
    # 
    # def profile_pic_url
    #     profile["profile_pic_url_hd"]
    # end
    
    # def claim_status
    #     claimed ? "claimed" : "unclaimed"
    # end
    
    # def instagram_link
    #     "https://instagram.com/#{username}"
    # end
    
    protected
    
    def send_welcome_email
        RequestMailer.send_welcome_email(self).deliver_now
    end
end
