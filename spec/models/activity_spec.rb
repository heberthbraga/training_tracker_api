require 'rails_helper'

RSpec.describe Activity, type: :model do
  it { should validate_presence_of(:training_session) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:phases) }
  it { is_expected.to validate_inclusion_of(:activity_type).in_array(%w(workout)) }
  it { is_expected.not_to validate_inclusion_of(:activity_type).in_array(%w(foo)) }
end