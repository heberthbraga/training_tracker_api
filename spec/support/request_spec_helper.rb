module RequestSpecHelper
  def json_response
    expect(response).not_to be_nil
    expect(response.body).not_to be_nil

    JSON.parse(response.body, symbolize_names: true)
  end
end