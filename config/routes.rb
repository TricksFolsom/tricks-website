Rails.application.routes.draw do

  resources :making_a_differences
  resources :kids_night_outs
  get 'datenights', to: redirect('kids_night_outs')
  resources :bff_dance_parties
  get 'employment_applications/new', to: redirect('https://tricksfolsom.com/employment', status: 301)
  resources :employment_applications, except: [:edit]
  resources :recital_sign_ups
  resources :parties, except: [:show]
  resources :camps
  root :to => 'static#index'

  get '(errors)/:status', to: 'errors#show', constraints: {status: /\d{3}/}  

  get 'coaches/type/:name' => "coaches#type"
  get 'coaches/loc/:name' => "coaches#loc"
  get 'coaches/past_employees' => "coaches#past_employees"

  get 'recital_ads/ad_select'
  get 'recital_ads_by_year/:year' => "recital_ads#by_year"
  get 'recital_ad_mailer/:id' => 'recital_ads#order_confirmation'

  resources :comments
  resources :kid_quotes
  resources :coaches
  resources :users
  resources :sessions
  resources :levels
  resources :recital_ads
  resources :recital_ad_types
  resources :promo_slides
  get 'absents/new', to: redirect('https://tricksfolsom.com/absence', status: 301)
  resources :absents
  resources :tricks_u_categories
  resources :tricks_u_videos
  resources :website_pdfs
  resources :discontinue_notices
  resources :bubble_contents

  %w[gymnastics tumblebunnies tag dance preschool_dance swim locations site_comments campus recital_ad_order_thank_you recital_info thankyou our_story safety_video food_drive summer_recital].each do |page|
    get page, controller: "static", action: page
  end

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
  get 'tricksu', to: 'tricks_u_videos#index'

  get 'tricksu/:category' => "tricks_u_videos#index"
  
  get 'levels/jr_request/:level_id' => "levels#get_jr_classes"
  get 'parties/jr_request/:party_id' => "parties#get_jr_parties"
  get 'parties/jr_request_all' => "parties#get_jr_parties_all"
  
  # patch 'employment_applications/:id/complete_interview', to: "employment_applications#complete_interview"
  # patch 'employment_applications/:id/update_review', to: "employment_applications#update_review"
  patch 'employment_applications/:id/update_review', to: "employment_applications#update_review"
  post 'employment_applications/:id', to: "employment_applications#archive"
  get 'employment', to: 'employment_applications#new'
end