require 'rails_helper'

RSpec.describe TrainingSession, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:deadline) }
  it { should validate_presence_of(:owner) }

  describe '#activities' do
    let!(:owner) { create(:registered) }
    let!(:training_session) { create(:training_session, owner: owner) }

    before do
      create(:activity_a, completed: true, training_session: training_session)
      create_list(:activity_a, 3, completed: false, training_session: training_session)
    end

    context 'fetch all' do
      it 'returns a list' do
        all_activities = training_session.activities

        expect(all_activities.size).to eq 4
      end
    end

    context 'fetch open' do
      it 'returns a list' do
        non_completed_activities = training_session.fetch_activities

        expect(non_completed_activities.size).to eq 3
      end
    end

    context 'fetch completed' do
      it 'returns a list' do
        completed_activities = training_session.fetch_activities({completed: true})
        expect(completed_activities.size).to eq 1
      end
    end
  end
end