# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:5173'

    resource '*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options]  # 允许所有 HTTP 方法
  end
end
