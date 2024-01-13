require_relative '../hash_map'

describe HashMap do
  describe '#set' do
    context 'When setting new node and reaching load factor' do
      before do
        allow(subject).to receive(:load_factor_reached?).and_return(true)
      end
      it 'pass conditions of #load_factor_reached? and calls resize array' do
        expect(subject).to receive(:resize_array).once
        subject.set
      end
    end
    context 'When threshold is not reached' do
      it 'calls #load_factor_reached and returns false when occupied is 1' do
        allow(subject).to receive(:length).and_return(1)
        subject.set
        updated_load_factor = subject.load_factor_reached?
        expect(updated_load_factor).to be_falsey
      end
      it 'calls #load_factor_reached and returns false when occupied is 5' do
        allow(subject).to receive(:length).and_return(5)
        subject.set
        updated_load_factor = subject.load_factor_reached?
        expect(updated_load_factor).to be_falsey
      end
      it 'calls #load_factor_reached and returns false when occupied is 11' do
        allow(subject).to receive(:length).and_return(11)
        subject.set
        updated_load_factor = subject.load_factor_reached?
        expect(updated_load_factor).to be_falsey
      end
    end
  end
  describe '#load_factor_reached?' do
    context 'When buckets at low capacity' do
      it 'returns false at capacity 5' do
        allow(subject).to receive(:length).and_return(5)
        result = subject.load_factor_reached?
        expect(result).to eq(false)
      end
      it 'returns false at capacity 10' do
        allow(subject).to receive(:length).and_return(10)
        result = subject.load_factor_reached?
        expect(result).to eq(false)
      end
      it 'returns false at capacity 11' do
        allow(subject).to receive(:length).and_return(11)
        result = subject.load_factor_reached?
        expect(result).to eq(false)
      end
    end
    context 'When buckets at high capacity' do
      it 'returns true at capacity 12' do
        allow(subject).to receive(:length).and_return(12)
        result = subject.load_factor_reached?
        expect(result).to eq(true)
      end
      it 'returns true at capacity 15' do
        allow(subject).to receive(:length).and_return(15)
        result = subject.load_factor_reached?
        expect(result).to eq(true)
      end
      it 'returns true at capacity 16' do
        allow(subject).to receive(:length).and_return(16)
        result = subject.load_factor_reached?
        expect(result).to eq(true)
      end
    end
    context 'When threshold is reached and overall capacity is 16' do
      it 'calls #load_factor_reached and returns true when occupied is 12' do
        allow(subject).to receive(:length).and_return(12)
        updated_load_factor = subject.load_factor_reached?
        expect(updated_load_factor).to be_truthy
      end
    end
    context 'When threshold is not reached and overall capacity is 32' do
      before do
        subject.instance_variable_set(:@capacity, 32)
      end
      it 'calls #load_factor_reached and returns false when occupied is 16' do
        allow(subject).to receive(:length).and_return(16)
        updated_load_factor = subject.load_factor_reached?
        expect(updated_load_factor).to be_falsey
      end
    end
  end

  describe '#length' do
    context 'When created 5 nodes' do
      it 'completes iteration and returns five' do
        5.times { subject.set }
        result = subject.length
        expect(result).to eq(5)
      end
    end
  end
end
