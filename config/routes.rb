Comments::Application.routes.draw do
  resources :website_pdfs


  resources :discontinue_notices


  root :to => 'static#index'

  match 'schedules/choose'  
  match 'schedules/gb_gym'
  match 'schedules/gb_tb'
  match 'schedules/gb_dance'
  match 'schedules/gb_tag'
  match 'schedules/fol_gym'
  match 'schedules/fol_tb'
  match 'schedules/fol_dance'
  match 'schedules/fol_swim'
  match 'schedules/fol_tag'
  match 'schedules/sac_gym'
  match 'schedules/sac_tb'
  match 'schedules/sac_dance'
  match 'schedules/sac_tag'
  match 'schedules/by_gym'

  match 'coaches/type/:name' => "coaches#type"
  match 'coaches/loc/:name' => "coaches#loc"
  match 'coaches/past_employees' => "coaches#past_employees"

  match 'recital_ads/ad_select'
  match 'recital_ad_mailer/:id' => 'recital_ads#order_confirmation'

  match 'datenights/edit' => 'datenights#edit'

  match 'choose_survey' => 'survey_results#choose_survey' 
  match 'survey_result_for/:name' => 'survey_results#survey_results_for' 
  match 'survey_results/:id' => 'survey_results#show' 

  resources :comments
  resources :kid_quotes
  resources :schedules
  resources :coaches
  resources :users
  resources :sessions
  resources :levels
  resources :recital_ads
  resources :recital_ad_types
  resources :promo_slides
  resources :surveys
  resources :survey_results
  resources :datenights
  resources :absents
  resources :worlds
  resources :tricks_u_categories
  resources :tricks_u_videos
  # resources :training_videos

  %w[gymnastics tumblebunnies tag dance swim events locations site_comments hosting competitive teamgym 
    birthdays princess_party camps dancecamps campus employment forms gymnastics25 
    missing nutcracker polkadots recitals recital_ad_order_thank_you show_schedules survey_thank_you 
    summer thankyou tricksu_old turkeycamp underconstruction registration].each do |page|
    get page, controller: "static", action: page
  end

  match 'dance_company' => 'dance_company#index'
  %w[index about auditions empty_page events gallery].each do |page|
    get 'dance_company/'+page, controller: 'dance_company', action: page
  end

  get 'database', to: 'static#app_landing'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'whereintheworld', to: 'worlds#new'
  get 'tricksu', to: 'tricks_u_videos#index', as: 'tricksu'

  match 'tricksu/:category' => "tricks_u_videos#index"

  match 'survey/:id/start' => 'survey_results#new', as: 'start_survey'
  match 'survey/:id/results' => 'survey_results#results_page', as: 'results_page'


end
