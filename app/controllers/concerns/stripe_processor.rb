module StripeProcessor
    def fetch_or_create_account_for(current_user, token, line1, city, state, postal_code, phone, dob, ssn)
        acct = begin
            Stripe::Account.retrieve(current_user.stripe_token)
        rescue
            Stripe::Account.create(
                :type => 'custom',
                :country => 'US',
                :default_currency => 'USD',
                :email => current_user.email,
                :requested_capabilities => ['card_payments'],
                :business_profile => {
                    :mcc => '7311',
                    :product_description => 'Social Media Advertiser'
                },
                :individual => {
                    :email => current_user.email,
                    :first_name => current_user.first_name,
                    :last_name => current_user.last_name,
                    :dob => {
                        :day => dob.split('/')[1],
                        :month => dob.split('/')[0],
                        :year => dob.split('/')[2]
                    },
                    :phone => phone,
                    :address => {
                        :line1 => line1,
                        :city => city,
                        :state => state,
                        :postal_code => postal_code
                    },
                    :ssn_last_4 => ssn
                },
                :business_type => 'individual',
                :settings => {
                    :payouts => {
                        :schedule => {
                            :interval => 'manual'
                        }
                    }
                },
                :tos_acceptance => {
                    :date => DateTime.now.to_i,
                    :ip => request.remote_ip
                }
            )
        end
        
        acct.external_account = token
        acct.save
        
        return acct
    end
    
    def process_payment(cost, token, receiver)
        amt = StripeProcessor.calculate_application_fee(cost) * 100
        cost = cost.to_f * 100
        
        charge = Stripe::Charge.create({
            amount: amt.to_i,
            currency: "usd",
            source: token,
            transfer_data: {
                amount: cost.to_i,
                destination: receiver.stripe_token,
            }
        })
        
        return charge
    end
    
    def process_payout_for(receiver)
        balance = Stripe::Balance.retrieve({ :stripe_account => receiver.stripe_token })
        balance_amt = balance["available"][0]["amount"]
        
        Stripe::Payout.create(
            {
                amount: balance_amt,
                currency: 'usd',
                method: 'instant',
                },
            { stripe_account: receiver.stripe_token }
        )
    end
    
    def self.calculate_application_fee(promo_cost)
        promo_cost = promo_cost.to_f
        return (promo_cost * 1.045) + 1.60
    end
    
    def account_updated(type, _params_)
        account = _params_[:account]
        user = User.find_by(stripe_token: account)
        verification = _params_[:data][:object][:individual][:verification]
        fields_needed = _params_[:data][:object][:individual][:requirements][:currently_due]
        due_by = _params_[:data][:object][:requirements][:current_deadline]
        
        if verification[:status] == 'verified' && !user.stripe_account_verified
            user.update(stripe_account_verified: true)
        end
        
        StripeLog.create(
            account: account,
            log_type: type,
            stripe_id: params[:id],
            authorization: verification[:status],
            fields_needed: fields_needed,
            due_by: due_by
        )
    end
    
    def external_account(type, _params_)
        account = params[:account]
        user = User.find_by(stripe_token: account)
        StripeLog.create(
            account: account,
            log_type: type,
            stripe_id: params[:id]
        )
        
        body = """
            We're glad that you're using MyRates to streamline your promos! This
            email is to let you know that your debit card has been verified and
            successfully added on file! That means you can now receive payouts
            directly to your card, without having to pay fees with app like
            Cashapp or PayPal. All you need to do now is to head over to your payout
            settings and make this your default payout method.
        """
        user.update(stripe_external_account_verified: true)
        return user, body
    end
    
    def payout_failed(type, _params_)
        account = params[:account]
        user = User.find_by(stripe_token: account)
        destination = params[:data][:object][:destination]
        StripeLog.create(
            account: account,
            log_type: type,
            stripe_id: params[:id],
            destination: destination
        )
        
        body = """
            We seem to be having some trouble sending payouts to your bank
            account. Try adding a different debit card, or contact your bank
            if the issue persists.
        """
        user.update(stripe_external_account_verified: true)
        return user, body
    end
    
    def payout_paid(type, _params_)
        account = params[:account]
        user = User.find_by(stripe_token: account)
        destination = params[:data][:object][:destination]
        StripeLog.create(
            account: account,
            log_type: type,
            stripe_id: params[:id],
            destination: destination
        )
        
        body = """
            A payout of $#{params[:data][:object][:amount]/100.0} has been sent
            to your account!
        """
        user.update(stripe_external_account_verified: true)
        return user, body
    end
    
    def payout_created(type, _params_)
        account = params[:account]
        destination = params[:data][:object][:destination]
        StripeLog.create(
            account: account,
            log_type: type,
            stripe_id: params[:id],
            destination: destination
        )
    end
    
    def application_deauthorized(type, _params_)
        account = params[:account]
        destination = params[:data][:object][:destination]
        StripeLog.create(
            account: account,
            log_type: type,
            stripe_id: params[:id],
            destination: destination
        )
    end
    
    def catch_all(type, _params_)
        account = params[:account]
        StripeLog.create(
            account: account,
            log_type: type,
            stripe_id: params[:id]
        )
    end
end