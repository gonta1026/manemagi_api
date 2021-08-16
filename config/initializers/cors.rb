Rails.application.config.middleware.insert_before 0, Rack::Cors do
  target_origin = "http://localhost:3000"
  if Rails.env.production?
    target_origin = "https://www.tatekae.work"
  end
  allow do
    origins target_origin
    resource "*",
      headers: :any,
      expose: ['access-token', 'uid', "client"],
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
        # credentials: true
  end
end