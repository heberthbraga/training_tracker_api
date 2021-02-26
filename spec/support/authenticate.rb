shared_context 'authenticate' do
  before do
    @user = create(:registered)
    create(:identity, provider: 'email', user: @user)
    
    post '/api/v1/sessions/email', params: { email: @user.email, password: @user.password }

    response = json_response

    access_token = response[:access_token]

    expect(access_token).not_to be_nil
    expect(response[:refresh_token]).not_to be_nil

    @headers = { 'Authorization' => "Bearer #{access_token}" }
  end
end

shared_context 'authenticate_admin' do
  before do
    @user = create(:admin)
    create(:identity, provider: 'email', user: @user)
    
    post '/api/v1/sessions/email', params: { email: @user.email, password: @user.password }

    response = json_response

    access_token = response[:access_token]

    expect(access_token).not_to be_nil
    expect(response[:refresh_token]).not_to be_nil

    @headers = { 'Authorization' => "Bearer #{access_token}" }
  end
end