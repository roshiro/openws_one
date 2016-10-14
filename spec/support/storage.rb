require "spec_helper"

shared_examples_for 'storage name validations' do |method_name, max_length|
  before :each do
    @result = described_class.send(method_name, param)
  end

  describe "when it has more than #{max_length} chars" do
    let(:param) { "this_is_a_long_param_name_that_should_fail" }

    it 'returns false' do
      expect(@result).to be false
    end
  end

  describe 'when it has invalid chars' do
    let(:param) { "invalid_param+_name*!@#" }

    it 'returns false' do
      expect(@result).to be false
    end
  end

  describe 'when it has valid chars' do
    let(:param) { "0-valid_proj-name-1" }

    it 'returns false' do
      expect(@result).to be true
    end
  end
end
