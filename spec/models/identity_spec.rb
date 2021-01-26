require 'rails_helper'

RSpec.describe Identity, type: :model do
  it { should validate_presence_of(:provider) }
end