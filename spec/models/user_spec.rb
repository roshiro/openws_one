require 'rails_helper'

describe User, type: :model do
  describe 'fields' do
    it { is_expected.to have_field(:email).of_type(String).with_default_value_of("") }
    it { is_expected.to have_field(:encrypted_password).of_type(String).with_default_value_of("") }
    it { is_expected.to have_field(:reset_password_token).of_type(String) }
    it { is_expected.to have_field(:reset_password_sent_at).of_type(Time) }
    it { is_expected.to have_field(:remember_created_at).of_type(Time) }
    it { is_expected.to have_field(:sign_in_count).of_type(Integer) }
    it { is_expected.to have_field(:current_sign_in_at).of_type(Time) }
    it { is_expected.to have_field(:last_sign_in_at).of_type(Time) }
    it { is_expected.to have_field(:current_sign_in_ip).of_type(String) }
    it { is_expected.to have_field(:last_sign_in_ip).of_type(String) }
  end
end
