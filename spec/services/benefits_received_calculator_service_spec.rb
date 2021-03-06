require 'rails_helper'
RSpec.describe BenefitsReceivedCalculatorService do
  subject(:service) { described_class }

  describe '#call' do
    it 'throws :invalid_inputs if nil given' do
      expect { service.call(benefits_received: nil) }.to throw_symbol(:invalid_inputs)
    end

    it 'throws :invalid_inputs with an instance that is invalid' do
      result = catch(:invalid_inputs) do
        service.call(benefits_received: nil)
      end
      expect(result).to be_a(described_class).and(an_object_having_attributes(valid?: false))
    end

    it 'states help is neither available or not availalble if the special "none" value is provided as a symbol' do
      result = service.call(benefits_received: [:none])
      expect(result).to have_attributes available_help: :undecided
    end

    it 'states help is neither available or not available if the special "dont_know" value is provided' do
      result = service.call(benefits_received: [:dont_know])
      expect(result).to have_attributes available_help: :undecided
    end

    it 'states that help is definitely available if any benefits are provided' do
      result = service.call(benefits_received: [:any_benefit])
      expect(result).to have_attributes available_help: :full
    end

    it 'states that the decision is final if any benefits are provided' do
      result = service.call(benefits_received: [:any_benefit])
      expect(result).to have_attributes final_decision?: true
    end
  end

  describe '#valid?' do
    it 'is true when all inputs required are present and correct type' do
      instance = service.new(benefits_received: [:none])
      expect(instance.valid?).to be true
    end

    it 'is false when the input is of incorrect type' do
      instance = service.new(benefits_received: "A wrong string")
      expect(instance.valid?).to be false
    end

    it 'is false when all input is nil' do
      instance = service.new(benefits_received: nil)
      expect(instance.valid?).to be false
    end

    it 'is false when all inputs are missing' do
      instance = service.new({})
      expect(instance.valid?).to be false
    end
  end
end
