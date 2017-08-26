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

  describe '#win?' do
    it 'should return false when 4 pieces are connected, but owned by different players' do
      3.times { |n| described_instance.update(1, n) }

      expect(described_instance.update(2, 3)).to eq :ok
    end

    it 'should return true when a player has 4 pieces connected in a row' do
      3.times { |n| described_instance.update(1, n) }

      expect(described_instance.update(1, 3)).to eq :win
    end

    it 'should return true when a player has 4 pieces connected in a column' do
      3.times { described_instance.update(1, 0) }

      expect(described_instance.update(1, 0)).to eq :win
    end

    it 'should return true when a player has 4 pieces connected diagonally' do
      3.times { |n| (n+1).times { described_instance.update(1, n) } }
      3.times { described_instance.update(2, 3) }

      expect(described_instance.update(1, 3)).to eq :win
    end

    it 'should return true when a player has 4 pieces connected diagonally \
        starting at 0,1 at going to the right' do
      3.times { |n| (n+1).times { described_instance.update(1, n+1) } }
      3.times { described_instance.update(2, 4) }

      expect(described_instance.update(1, 4)).to eq :win
    end

    it 'should return true when a player has 4 pieces connected diagonally \
        starting at 1,0 and going to the right' do
      4.times { |n| described_instance.update('x', n+1) }
      3.times { |n| (n+1).times { described_instance.update('x', n+2) } }
      3.times { |n| described_instance.update(1, n+1) }

      expect(described_instance.update(1, 4)).to eq :win
    end

    it 'should return true when a player has 4 pieces connected diagonally \
        starting at 5,1 and going to the right' do
      4.times { |n| described_instance.update(0, n+1) }
      3.times { |n| (n+1).times { described_instance.update(0, 3-n) } }
      3.times { |n| described_instance.update(1, n+2) }

      expect(described_instance.update(1, 1)).to eq :win
    end
  end

  describe '#tie?' do
    it 'should return tie when the board is full' do
      cs = described_instance.columns

      cs.times do |c|
        (described_instance.rows-1).times do
          described_instance.update(0, c)
        end
      end

      (cs-1).times { |c| described_instance.update(0, c) }

      expect(described_instance.update(1, cs-1)).to eq :tie
    end
  end
end

