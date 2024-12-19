require 'httparty'

module Integration
  class QrApi
    def initialize(params, user_params)
      @params = params
      @user_params = user_params
    end

    def create_qr_code
      body = @params.merge(@user_params).to_json

      HTTParty.post("http://127.0.0.1:5000/generate_qr",
                    body: body,
                    headers: { 'Content-Type': 'application/json' })
    end

    def concat
      body = @params.merge(@user_params)
      HTTParty.post("http://127.0.0.1:5000/concat", body: body.to_json, headers: { 'Content-Type': "application/json" })
    end
  end
end