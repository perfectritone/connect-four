require 'board'

describe Board do

  let(:described_instance) { Board.new }

  describe "#initialized" do
    it 'should be empty' do
      non_nil_spaces = described_instance.board.find { |r| r.find { |c| !c.nil? } }
      expect(non_nil_spaces).to be_nil
    end
  end

  describe '#update' do
    it 'should add a piece to the bottom of the board' do
      described_instance.update(1, 0)

      expect(described_instance.board[-1][0]).to eq 1
    end

    it 'should add stack a piece when there is already a piece in the column' do
      described_instance.update(1, 0)
      described_instance.update(1, 0)

      expect(described_instance.board[-1][0]).to eq 1
      expect(described_instance.board[-2][0]).to eq 1
    end

    it 'should not change any other part of the board when a piece is added' do
      described_instance.update(1, 2)

      expect(described_instance.board[-1][2]).to eq 1

      non_nil_spaces = described_instance.board.sum {|row| row.compact.sum}
      expect(non_nil_spaces).to eq 1
    end

    it 'should allow for a second player' do
      described_instance.update(2, 0)

      expect(described_instance.board[-1][0]).to eq 2
    end

    it 'should return :invalid when row is full' do
      7.times { described_instance.update(1, 0) }

      expect(described_instance.update(1, 0)).to eq :invalid
    end

    it 'should return :ok on success' do
      expect(described_instance.update(1, 0)).to eq :ok
    end

    it 'should not allow a space to be updated out of bounds; column max' do
      expect(described_instance.update(1, 7)).to eq :invalid
    end

    it 'should not allow a space to be updated out of bounds; column min' do
      expect(described_instance.update(1, -1)).to eq :invalid
    end
  end
end

