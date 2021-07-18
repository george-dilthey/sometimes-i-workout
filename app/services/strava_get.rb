class StravaGet

    def initialize
      client = Strava::OAuth::Client.new(
        client_id: ENV["STRAVA_CLIENT_ID"],
        client_secret: ENV["STRAVA_CLIENT_SECRET"]
      )
      
      redirect_url = client.authorize_url(
        redirect_uri: 'https://localhost3000/oauth',
        approval_prompt: 'force',
        response_type: 'code',
        scope: 'activity:read_all',
        state: 'magic'
      )    

      response = client.oauth_token(code: '1234556789901234567890')

      response.access_token # access token
      response.refresh_token # refresh token
      response.expires_at
    end

end