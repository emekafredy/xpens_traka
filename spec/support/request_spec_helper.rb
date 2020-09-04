module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    auth_value = {
      info: {
        name: "John Doe",
        email: "john.doe@example.com",
        first_name: "John",
        last_name: "Doe"
      },
      credentials: {
        token: "k90oitoi093o0292od9u0i908hiy94ji90ouo498u9u3u",
        refresh_token: "iuo9uu49iu038u903jhc8",
        expires_at: DateTime.now,
        expires: true
      }
    }

    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new(auth_value)
    User.create_from_provider_data(auth_value)
  end
end
