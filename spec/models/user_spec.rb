require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  context 'is admin' do
    before do
      create(:admin)
    end

    it { expect(User.first.admin?).to be true }
  end

  context 'is newuser' do
    before do
      create(:newuser)
    end

    it { expect(User.first.newuser?).to be true }
  end

  context 'is registered' do
    before do
      create(:registered)
    end

    it { expect(User.first.registered?).to be true }
  end
end