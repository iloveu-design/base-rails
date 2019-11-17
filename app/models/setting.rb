class Setting < RailsSettings::Base
  #cache_prefix { "v1" }

  field :site_name, type: :string, default: 'Base Rails'
  field :host, type: :string, default: "http://rails.test"
  field :admin_emails, default: "admin@rubyonrails.org", type: :array
  field :captcha_enable, type: :boolean, default: 1
  field :notification_options, type: :hash, default: {
    send_all: true,
    logging: true,
    sender_email: "foo@bar.com"
  }
  field :op_items, type: :hash, default: {
    main_sliders: { "name" => "enter names here", "title" => "string", "body" => "text", "image" => "image" }
  }

  # Define your fields
  # field :host, type: :string, default: "http://localhost:3000"
  # field :default_locale, default: "en", type: :string
  # field :confirmable_enable, default: "0", type: :boolean
  # field :admin_emails, default: "admin@rubyonrails.org", type: :array
  # field :omniauth_google_client_id, default: (ENV["OMNIAUTH_GOOGLE_CLIENT_ID"] || ""), type: :string, readonly: true
  # field :omniauth_google_client_secret, default: (ENV["OMNIAUTH_GOOGLE_CLIENT_SECRET"] || ""), type: :string, readonly: true
end
