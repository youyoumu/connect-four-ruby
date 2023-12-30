require "./lib/board.rb"

describe Board do
  subject(:game) { described_class.new() }
  let(:board) { game.instance_variable_get(:@board) }
  let(:mark) { "⚫" }

  describe "#draw_board" do
    it "draw the board nicely" do
      game.draw_board
      expect true
    end
  end

  describe "#drop_ball" do
    context "when the column is empty" do
      it "place the ball at the most bottom row" do
        game.drop_ball(1, mark)
        expect(board[5][0]).to eq(mark)
      end
    end

    context "when the column 1 is filled with 1 ball" do
      before do
        board[5][0] = mark
      end

      it "place the ball at 1 row higher at column 1" do
        game.drop_ball(1, mark)
        expect(board[4][0]).to eq(mark)
      end
    end
  end

  describe "#check_high" do
    context "when the column 1 is filled with 3 balls" do
      before do
        board[5][0] = mark
        board[4][0] = mark
        board[3][0] = mark
      end

      it "return 3" do
        expect(game.check_high(1)).to eq(3)
      end
    end
  end

  describe "#input_valid?" do
    it "return false if the input is not string number 1-7" do
      expect(game.input_valid?("8")).to eq(false)
    end

    it "return false if the input is a letter" do
      expect(game.input_valid?("asd")).to eq(false)
    end

    it "return true if the input is string number 1-7" do
      expect(game.input_valid?("2")).to eq(true)
    end

    context "when the column 1 is full" do
      before do
        board[5][0] = mark
        board[4][0] = mark
        board[3][0] = mark
        board[2][0] = mark
        board[1][0] = mark
        board[0][0] = mark
      end

      it "return false even if the input is 1" do
        expect(game.input_valid?("1")).to eq(false)
      end

      it "return true even if the input is 2" do
        expect(game.input_valid?("2")).to eq(true)
      end

      it "#check_high(1) will return 6" do
        expect(game.check_high(1)).to eq 6
      end
    end
  end
end