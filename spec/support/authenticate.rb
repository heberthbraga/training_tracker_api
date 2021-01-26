shared_context 'authenticate' do
  before do
    @user = create(:registered)
    create(:identity, provider: 'email', user: @user)
    
    post '/api/v1/sessions/email', params: { email: @user.email, password: @user.password }

    response = json_response

    expect(response).not_to be_nil
    expect(response[:user_id]).to eq @user.id
  end
end

shared_context 'authenticate_admin' do
  before do
    @user = create(:admin)
    create(:identity, provider: 'email', user: @user)
    
    post '/api/v1/sessions/email', params: { email: @user.email, password: @user.password }

    response = json_response

    expect(response).not_to be_nil
    expect(response[:user_id]).to eq @user.id
  end
end