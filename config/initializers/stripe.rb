if Rails.env == "development"
    Rails.configuration.stripe = {
        :publishable_key => "pk_test_qLHYek2ZzEiXo8XEKJpApGoF00PfhLvqts",
        :secret_key      => "sk_test_9zAsWhkLyw5U7iDzssBOGhpl00V5IgnXdq"
    }
else
    Rails.configuration.stripe = {
        :publishable_key => ENV["STRIPE_PUBLISHABLE"],
        :secret_key      => ENV["STRIPE_SECRET"]
    }
end
Stripe.api_key = Rails.configuration.stripe[:secret_key]